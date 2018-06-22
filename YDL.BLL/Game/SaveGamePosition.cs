
using System.Collections.Generic;
using System.Linq;

using Newtonsoft.Json;
using YDL.Core;
using YDL.Map;
using YDL.Model;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 第二轮淘汰赛，保存按人抽签
    /// </summary>
    public class SaveGamePosition : IService
    {
        /// <summary>
        /// 第二轮淘汰赛，保存按人抽签
        /// </summary>
        /// <param name="request">Request.GameOrder.Entities</param>
        /// <returns>Response.EmptyEntity</returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GameOrder>>(request);
            var temp = req.FirstEntity();

            //验证数据
            var valResult = Validate(temp);
            if (!valResult.IsSuccess)
            {
                return valResult;
            }

            var firstOrder = GameHelper.GetGameOrder(req.Entities.First().Id);
            //设置新的位置列表
            firstOrder.PositionList = temp.PositionList;

            //缓存KnockOutAB,保存之前再恢复
            string tempKnockOutAB = firstOrder.KnockOutAB;
            firstOrder.KnockOutAB = temp.KnockOutAB.IsNotNullOrEmpty() ? temp.KnockOutAB : KnockOutAB.A;

            //设置AB选项
            var game = GameHelper.GetGame(firstOrder.GameId);
            firstOrder.SetKnockOutAB(game.IsKnockOutAB);

            var entities = new List<EntityBase>();
            //获取第二轮淘汰比赛所有场次（非附加赛）
            List<GameLoop> loopList = null;

            //获取第二轮编号（用于小组循环后淘汰）
            var actualNextOrderId = temp.KnockOutAB == KnockOutAB.B ? firstOrder.NextOrderBId : firstOrder.NextOrderId;
            if (firstOrder.KnockoutOption == KnockoutOption.ROUND.Id)
            {
                //小组循环后淘汰，设置本轮次结束，并获取下轮次比赛
                firstOrder.State = GameOrderState.FINISH.Id;
                firstOrder.SetRowModified();
                entities.Add(firstOrder);

                //获取第二轮比赛     
                loopList = GameHelper.GetOrderLoopListNoExtra(actualNextOrderId);
            }
            else
            {
                //单淘汰，获取第一轮比赛
                var cmd = CommandHelper.CreateText<GameLoop>();
                cmd.Text = "SELECT * FROM GameLoop WHERE GameId=@gameId AND OrderId=@orderId AND IsExtra=0 AND ISNULL(KnockLoopId,'')='' ORDER BY OrderNo";
                cmd.Params.Add("@gameId", firstOrder.GameId);
                cmd.Params.Add("@orderId", firstOrder.Id);
                loopList = DbContext.GetInstance().Execute(cmd).Entities.ToList<EntityBase, GameLoop>();
            }
            //将相邻位置球员进入对应场次比赛
            SetEnterKnockPos(firstOrder, entities, loopList);

            var cmdSave = CommandHelper.CreateSave(entities);
            //保存之前删除原来抢位赛（单淘汰为第一轮，小组循环后为第二轮）
            var cmdDelete = CommandHelper.CreateText(FetchType.Execute, "DELETE FROM GameLoop WHERE GameId=@gameId AND OrderId=@orderId AND ISNULL(KnockLoopId,'')!=''");
            cmdDelete.Params.Add("@gameId", firstOrder.GameId);
            cmdDelete.Params.Add("@orderId", firstOrder.KnockoutOption == KnockoutOption.ROUND.Id ? actualNextOrderId : firstOrder.Id);

            cmdSave.PreCommands = new List<Command> { cmdDelete };

            //保存前恢复firstOrder.KnockOutAB原数据（小组赛第一轮为空）
            firstOrder.KnockOutAB = tempKnockOutAB;

            return DbContext.GetInstance().Execute(cmdSave);
        }

        private static Response Validate(GameOrder order)
        {
            //验证人员设置
            if (order.PositionList.IsNullOrEmpty())
            {
                return ResultHelper.Fail("请设置所有位置人员，再保存。");
            }

            //验证重复设置
            foreach (var obj in order.PositionList)
            {
                if (obj.UserId.IsNotNullOrEmpty() && IsExists(order.PositionList, obj))
                {
                    return ResultHelper.Fail("某人员被设置到了多个位置，请修改后再保存。");
                }
            }

            //验证相邻奇偶位置至少有一人
            for (int i = 0; i < order.PositionList.Count / 2; i++)
            {
                if (order.PositionList[i * 2].UserId.IsNullOrEmpty() && order.PositionList[i * 2 + 1].UserId.IsNullOrEmpty())
                {
                    string msg = string.Format("{0}和{1}位置都没有人员，请至少设置1人再保存。", i * 2 + 1, i * 2 + 2);
                    return ResultHelper.Fail(msg);
                }
            }

            return ResultHelper.Success();
        }

        /// <summary>
        /// 设置淘汰赛位置人员
        /// </summary>
        /// <param name="order"></param>
        /// <param name="entities"></param>
        /// <param name="secondLoopList"></param>
        public static void SetEnterKnockPos(GameOrder order, List<EntityBase> entities, List<GameLoop> secondLoopList)
        {
            for (int i = 0; i < secondLoopList.Count; i++)
            {
                var pos1 = order.PositionList[i * 2];
                var pos2 = order.PositionList[i * 2 + 1];

                var loop = secondLoopList[i];
                if (pos1.KnockUserId.IsNotNullOrEmpty() || pos2.KnockUserId.IsNotNullOrEmpty())
                {
                    //建立抢位赛
                    SetKnockLoop(entities, pos1, pos2, loop);
                }
                else
                {
                    loop.Team1Id = pos1.UserId.GetId();
                    loop.Team2Id = pos2.UserId.GetId();
                    loop.IsKnock = false;
                }

                loop.SetRowModified();
                entities.Add(loop);
            }
        }

        private static void SetKnockLoop(List<EntityBase> entities, GamePosition pos1, GamePosition pos2, GameLoop loop)
        {

            if (pos1.KnockUserId.IsNotNullOrEmpty())
            {
                var knock1 = loop.CreateObj<GameLoop>();
                knock1.SetNewEntity();
                knock1.OrderNo = 0;
                knock1.Remark = string.Format("第{0}场抢号赛", loop.OrderNo);

                knock1.Team1Id = pos1.UserId.GetId();
                knock1.Team2Id = pos1.KnockUserId.GetId();

                knock1.KnockLoopId = loop.Id;
                knock1.IsKnock = true;

                entities.Add(knock1);
            }

            if (pos2.KnockUserId.IsNotNullOrEmpty())
            {
                var knock2 = loop.CreateObj<GameLoop>();
                knock2.SetNewEntity();
                knock2.OrderNo = 0;
                knock2.Remark = string.Format("第{0}场抢号赛", loop.OrderNo);

                knock2.Team1Id = pos2.UserId.GetId();
                knock2.Team2Id = pos2.KnockUserId.GetId();

                knock2.KnockLoopId = loop.Id;
                knock2.IsKnock = true;

                entities.Add(knock2);
            }

            loop.Team1Id = pos1.KnockUserId.IsNullOrEmpty() ? pos1.UserId.GetId() : null;
            loop.Team2Id = pos2.KnockUserId.IsNullOrEmpty() ? pos2.UserId.GetId() : null;
            loop.IsKnock = true;
        }

        private static bool IsExists(List<GamePosition> list, GamePosition pos)
        {
            foreach (var obj in list)
            {
                if (obj.UserId.IsNotNullOrEmpty() && obj.UserId.GetId() == pos.UserId.GetId() && obj.Index != pos.Index)
                {
                    return true;
                }
            }
            return false;
        }

    }
}
