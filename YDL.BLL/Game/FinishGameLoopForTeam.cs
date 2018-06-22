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
    /// 团体比赛结束一次对决
    /// </summary>
    public class FinishGameLoopForTeam : IService
    {
        /// <summary>
        /// 团体比赛结束一次对决
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

            IWaiver waiver = new TeamWaiver();
            if (loop.WaiverOption.IsNotNullOrEmpty())
            {
                waiver.SetWaiver(loop);
            }
            else
            {
                waiver.SetScore(loop);
                var order = GameHelper.GetGameOrder(loop.OrderId.GetId());

                //验证爱猕模式需要打完所有对阵
                if (order.TeamScoreMode == TeamScoreMode.SINGLE_RACE.Id)
                {
                    if (loop.Team1 + loop.Team2 != order.WinTeam * 2 - 1)
                    {
                        return ResultHelper.Fail(string.Format("需要打满{0}场。", order.WinTeam * 2 - 1));
                    }
                }
                else
                {

                    int max = loop.Team1 > loop.Team2 ? loop.Team1 : loop.Team2;
                    if (max < order.WinTeam)
                    {
                        //团队比赛胜场检查
                        return ResultHelper.Fail(string.Format("胜方需要赢{0}场。", order.WinTeam));
                    }
                }
            }

            List<EntityBase> entities = new List<EntityBase>();
            entities.Add(loop);
            SetNextLoop(loop, entities);

            var cmdSave = CommandHelper.CreateSave(entities);
            //更新个人积分
            var cmdUpdateScore = CommandHelper.CreateProcedure(FetchType.Execute, "sp_UpdateGameSportScoreForTeam");
            cmdUpdateScore.Params.Add("@GameId", loop.GameId);
            cmdUpdateScore.Params.Add("@LoopId", loop.Id.GetId());
            cmdSave.AfterCommands = new List<Command> { cmdUpdateScore };

            return DbContext.GetInstance().Execute(cmdSave);
        }

        private static void SetNextLoop(GameLoop loop, List<EntityBase> entities)
        {
            if (loop.GroupId.IsNullOrEmpty() && loop.Team1 != loop.Team2)
            {
                var nextOrderLoops = GameHelper.EnterNextGameLoop(loop);
                if (nextOrderLoops.IsNotNullOrEmpty())
                {
                    entities.AddRange(nextOrderLoops);
                }
            }
        }

    }
}
