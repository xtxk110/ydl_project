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
    /// 删除比赛队伍
    /// </summary>
    public class DeleteGameTeam : IService
    {
        /// <summary>
        /// 删除比赛队伍
        /// </summary>
        /// <param name="currentUser">忽略</param>
        /// <param name="request"><Request.GameTeam.Filter</param>
        /// <returns>Response.EmptyEntity</returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GameTeam>>(request);

            var cmd = CommandHelper.CreateProcedure(FetchType.Execute, "sp_DeleteGameTeam");
            cmd.Params.Add("@GameId", req.Filter.GameId);
            cmd.Params.Add("@CreatorId", req.Filter.CreatorId);
            cmd.CreateParamMsg();

            return DbContext.GetInstance().Execute(cmd);
        }
    }
}
