using System;
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
    /// 单打比赛保存比赛结果详情，每次保存一次对阵结果,单打比赛要设置比赛结束
    /// </summary>
    public class FinishGameLoopForOne : IService
    {
        /// <summary>
        /// 单打比赛保存比赛结果详情，每次保存一次对阵结果,单打比赛要设置比赛结束
        /// </summary>
        /// <param name="currentUser">忽略</param>
        /// <param name="request">Request.GameLoop.Entities</param>
        /// <returns>Response.EmptyEntity</returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GameLoop>>(request);
            var temp = req.FirstEntity();

            //非轮空，非双方弃权，需要胜方签名
            if (!temp.IsBye && temp.WaiverOption != WaiverOption.AB && Ext.IsNullOrEmpty(temp.WinSign))
            {
                return ResultHelper.Fail("非轮空，非双方弃权，需要胜方签名。");
            }

            var loop = GameHelper.GetLoop(temp.Id);
            //从数据库取出，重新赋值
            loop.IsBye = req.Entities.First().IsBye;
            loop.State = GameLoopState.FINISH.Id;
            loop.DetailList = temp.DetailList;
            loop.WaiverOption = temp.WaiverOption.GetId();
            loop.WinSign = temp.WinSign;
            loop.JudgeSign = temp.JudgeSign;
            //更新结束时间
            loop.EndTime = DateTime.Now;
            if (loop.StartTime == null)
            {
                loop.StartTime = loop.EndTime;
            }
            loop.SetRowModified();

            loop.Team1Id = loop.Team1Id.GetId();
            loop.Team2Id = loop.Team2Id.GetId();

            var entities = new List<EntityBase>();
            IWaiver waiver = new OneWaiver();
            if (loop.WaiverOption.IsNotNullOrEmpty())
            {
                waiver.SetWaiver(loop);
            }
            else
            {
                waiver.SetScore(loop);
                var order = GameHelper.GetGameOrder(loop.OrderId.GetId());

                int max = loop.Game1 > loop.Game2 ? loop.Game1 : loop.Game2;
                if (max != order.WinGame)
                {
                    //个人比赛胜局检查
                    return ResultHelper.Fail(string.Format("胜方需要赢{0}局。", order.WinGame));
                }

                foreach (var item in loop.DetailList)
                {
                    //item.SetNewEntity();
                    item.LoopId = loop.Id.GetId();
                    int maxFen = item.Fen1 > item.Fen2 ? item.Fen1 : item.Fen2;
                    if (maxFen >= 11)//大致判小局分数是否有效
                    {
                        item.RowState = RowState.Modified;//获取小局对阵列表时,已经生成空对阵,故此处只需要保存相应小局的得分,状态更改为修改状态
                        entities.Add(item);
                    }
                    entities.Add(item);
                }
            }

            entities.Add(loop);
            SetNextLoopUser(loop, entities);

            var cmdSave = CommandHelper.CreateSave(entities);
            //cmdSave.PreCommands = new List<Command> { GameHelper.GetDeleteLoopDetailCmd(loop.Id, null) };//此处不需要再删除原有的对阵
            //更新个人积分
            var cmdUpdateScore = CommandHelper.CreateProcedure(FetchType.Execute, "sp_UpdateGameSportScoreForOne");
            cmdUpdateScore.Params.Add("@GameId", loop.GameId);
            cmdUpdateScore.Params.Add("@LoopId", loop.Id.GetId());
            cmdSave.AfterCommands = new List<Command> { cmdUpdateScore };


            return DbContext.GetInstance().Execute(cmdSave);
        }

        private static void SetNextLoopUser(GameLoop loop, List<EntityBase> entities)
        {
            if (loop.GroupId.IsNullOrEmpty() && loop.Game1 != loop.Game2)
            {
                var nextOrderLoops = GameHelper.EnterNextGameLoop(loop);
                if (nextOrderLoops.IsNotNullOrEmpty())
                {
                    //保存后轮比赛晋级人员
                    entities.AddRange(nextOrderLoops);
                }
            }
        }

    }
}
