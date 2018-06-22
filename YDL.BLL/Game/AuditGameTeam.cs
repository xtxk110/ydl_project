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
    /// 审核比赛报名队伍资格
    /// </summary>
    public class AuditGameTeam : IService
    {
        /// <summary>
        /// 审核比赛报名队伍资格
        /// </summary>
        /// <param name="currentUser">忽略</param>
        /// <param name="request">Request.GameTeam.Entities</param>
        /// <returns>Response.EmptyEntity</returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GameTeam>>(request);
            var team = req.Entities.FirstOrDefault();
            team.AuditDate = DateTime.Now;
            team.SetRowModified();
            var cmd = CommandHelper.CreateSave(req.Entities);
            cmd.OnlyFields = new List<TableFieldPair> { new TableFieldPair { Table = "GameTeam", Fields = "AuditRemark,State,AuditDate,AuditorId" } };

            var result = DbContext.GetInstance().Execute(cmd);
            try
            {
                var state = GameTeamState.find(team.State.GetId());
                var game = GameHelper.GetGame(team.GameId.GetId());
                var msg = string.Format("您参加[{0}]比赛的申请被{1}。{2}", 
                    team.TeamName, state.Name, game.Cost > 0 
                    && !team.IsPayCost ? "请及时支付报名费。" : string.Empty);
                JPushHelper.SendNotify(MasterType.GAME.Id, game.Id, msg, new List<string> { team.TeamUserId});
            }
            catch (Exception)
            {
            }

            return result;
        }
    }
}
