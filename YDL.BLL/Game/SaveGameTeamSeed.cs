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
    /// 修改队伍种子情况
    /// </summary>
    public class SaveGameTeamSeed : IService
    {
        /// <summary>
        /// 修改队伍种子情况
        /// </summary>
        /// <param name="currentUser">忽略</param>
        /// <param name="request">Request.GameTeam</param>
        /// <returns>Response.EmptyEntity</returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GameTeam>>(request);
            var cmd = CommandHelper.CreateSave(req.Entities);
            foreach (var team in req.Entities)
            {
                team.IsSeed = team.SeedNo > 0;
            }
            cmd.OnlyFields = new List<TableFieldPair> { new TableFieldPair { Table = "GameTeam", Fields = "IsSeed,SeedNo" } };

            return DbContext.GetInstance().Execute(cmd);
        }
    }
}
