using System;
using System.Text;
using System.Linq;
using System.Collections.Generic;

using Newtonsoft.Json;
using YDL.Core;
using YDL.Map;
using YDL.Model;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 单淘汰，按人抽签
    /// </summary>
    public class GetGamePositionListForKnock : IService
    {
        /// <summary>
        /// 单淘汰，按人抽签
        /// </summary>
        /// <param name="request">Request.GameOrder.Entities</param>
        /// <returns>Response.EmptyEntity</returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GameOrder>>(request);
            var order = GameHelper.GetGameOrder(req.Filter.Id);
            if (order.State != GameOrderState.NOTSTART.Id)
            {
                return ResultHelper.Fail("比赛已经开始，不能再进行抽签。");
            }

            var memberList = GetGameTeamList(order);
            if (memberList.IsNullOrEmpty())
            {
                return ResultHelper.Fail("无参赛人员，不能进行抽签。");
            }

            //参照2名算法
            order.KnockoutCount = 2;
            order.SetKnockOutAB(GameHelper.GetGame(order.GameId).IsKnockOutAB);

            //获取1，2名位置列表
            var posListAll = KnockoutDrawHelper.CalRankPosAndSort(order.KnockoutTotal, order.KnockoutCount, 1);
            var posListTwo = KnockoutDrawHelper.CalRankPosAndSort(order.KnockoutTotal, order.KnockoutCount, 2);
            posListAll.AddRange(posListTwo);
            //初始化所有位置
            order.PositionList = new List<GamePosition>();
            for (int i = 0; i < order.KnockoutTotal; i++)
            {
                order.PositionList.Add(new GamePosition { Index = i });
            }
            //取小值循环
            int count = Math.Min(posListAll.Count, memberList.Count);
            for (int i = 0; i < count; i++)
            {
                order.PositionList[posListAll[i]].UserId = memberList[i].Id.Link(memberList[i].TeamName);
                if (i < posListAll.Count / 2)
                {
                    order.PositionList[posListAll[i]].IsSeed = true;
                }
                memberList[i].IsEnterPos = true;
            }
            //检查轮空或者抢号
            CheckByeOrKnock(order, posListAll, memberList);
            //检查相同单位
            GetGamePositionList.CheckSameCorpTeamId(order);

            var resultOrder = ResultHelper.Success(new List<EntityBase> { order });
            return resultOrder;
        }

        private static List<GameTeam> CheckByeOrKnock(GameOrder order, List<int> posListAll, List<GameTeam> memberList)
        {
            var emptyCount = Math.Abs(order.KnockoutTotal - memberList.Count);
            if (emptyCount > 0)
            {
                if (order.KnockoutTotal > memberList.Count)
                {
                    //设置轮空
                    for (int i = 0; i < emptyCount; i++)
                    {
                        var pos = posListAll[i] % 2 == 0 ? posListAll[i] + 1 : posListAll[i] - 1;
                        //查找本middle区域非轮空的空位
                        var targetPos = order.PositionList.FirstOrDefault(p => 
                        p.Index / order.Middle() == pos / order.Middle() && p.UserId.IsNullOrEmpty() && !p.IsBye);
                        if (targetPos != null)
                        {
                            targetPos.UserId = order.PositionList[pos].UserId;
                            targetPos.GroupId = order.PositionList[pos].GroupId;
                            order.PositionList[pos].UserId = null;
                            order.PositionList[pos].GroupId = null;
                            order.PositionList[pos].IsBye = true;
                        }
                    }
                }
                else
                {
                    //抢号人员
                    var knockList = memberList.Where(p => p.IsEnterPos == false).ToList();
                    //设置抢号，取小值循环
                    int count = Math.Min(Math.Min(emptyCount, knockList.Count), posListAll.Count);
                    for (int i = 0; i < count; i++)
                    {
                        var pos = posListAll[i] % 2 == 0 ? posListAll[i] + 1 : posListAll[i] - 1;
                        order.PositionList[pos].KnockUserId = knockList[i].Id.Link(knockList[i].TeamName);
                    }
                }
            }
            return memberList;
        }

        private static List<GameTeam> GetGameTeamList(GameOrder currentOrder)
        {
            var cmdMember = CommandHelper.CreateProcedure<GameTeam>(text: "sp_GetGameTeamListForKnock");
            cmdMember.Params.Add(CommandHelper.CreateParam("@gameId", currentOrder.GameId));
            var memberList = DbContext.GetInstance().Execute(cmdMember).Entities.ToList<EntityBase, GameTeam>();

            return memberList;
        }

    }
}
