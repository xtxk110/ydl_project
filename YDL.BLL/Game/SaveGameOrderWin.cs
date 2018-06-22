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
    /// 设置轮次胜局选项
    /// </summary>
    public class SaveGameOrderWin : IService
    {
        /// <summary>
        /// 修改队伍种子情况
        /// </summary>
        /// <param name="currentUser">忽略</param>
        /// <param name="request">Request.GameTeam</param>
        /// <returns>Response.EmptyEntity</returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GameOrder>>(request);
            foreach (var obj in req.Entities)
            {
                obj.TeamScoreMode = obj.TeamScoreMode.GetLinkId();
                var valResult = CheckWinOption(obj);
                if (!valResult.IsSuccess)
                {
                    return ResultHelper.Fail(valResult.Message);
                }
            }
            var cmd = CommandHelper.CreateSave(req.Entities);
            cmd.OnlyFields = new List<TableFieldPair> { new TableFieldPair { Table = "GameOrder", Fields = "WinTeam,WinGame,TeamScoreMode" } };
            return DbContext.GetInstance().Execute(cmd);
        }

        private static ValidationResult CheckWinOption(GameOrder obj)
        {
            if (obj.IsTeam)
            {
                ////直接根据模板规则得出团体胜局数,迎合新团体模板规则  20180601 zq
                string sqlStr = "SELECT CASE WHEN ISNULL(a2.LoopCount, 0)=0 THEN 0 ELSE a2.LoopCount/2+1 END AS WinLoopCount FROM Game a1 INNER JOIN GameTeamLoopTemplet a2 ON a1.TeamMode=a2.Id WHERE a1.Id=@gameId";
                var cmd = CommandHelper.CreateText<Game>(FetchType.Fetch, sqlStr);
                cmd.Params.Add("@gameId", obj.GameId);
                var res = DbContext.GetInstance().Execute(cmd);
                try
                {
                    if (res.Entities.Count > 0)
                    {
                        obj.WinTeam = res.FirstEntity<Game>().WinLoopCount;
                    }
                }
                catch { }

                if (obj.WinTeam == 0)
                {
                    return new ValidationResult { IsSuccess = false, Message = "请设置团队胜场。" };
                }

                if (obj.KnockoutOption == KnockoutOption.ROUND.Id && obj.TeamScoreMode.IsNullOrEmpty())
                {
                    return new ValidationResult { IsSuccess = false, Message = "请设置团队循环比赛的计分模式。" };
                }

            }
            else
            {
                obj.WinTeam = 0;
            }

            if (obj.WinGame == 0)
            {
                return new ValidationResult { IsSuccess = false, Message = "请设置胜局。" };
            }

            return new ValidationResult { IsSuccess = true }; ;
        }
    }
}
