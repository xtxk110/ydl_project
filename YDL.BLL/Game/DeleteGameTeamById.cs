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
    public class DeleteGameTeamById : IServiceBase
    {
        /// <summary>
        /// 参赛队伍报名
        /// </summary>
        /// <param name="currentUser">忽略</param>
        /// <param name="request"><Request.GameTeam.Filter</param>
        /// <returns>Response.EmptyEntity</returns>
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GameTeam>>(request);

            var cmdQuery = CommandHelper.CreateText(FetchType.Scalar, "SELECT CreatorId FROM dbo.Game WHERE Id=@gameId");
            cmdQuery.Params.Add("@gameId", req.Filter.GameId);
            var result = DbContext.GetInstance().Execute(cmdQuery);
            if (result.Tag as string != currentUser.Id)
            {
                return ResultHelper.Fail("比赛管理员才有权限删除队伍。");
            }

            var cmd = CommandHelper.CreateProcedure(FetchType.Execute, "sp_DeleteGameTeamById");
            cmd.Params.Add("@teamId", req.Filter.Id);
            cmd.Params.Add("@gameId", req.Filter.GameId);
            cmd.CreateParamMsg();

            return DbContext.GetInstance().Execute(cmd);
        }
    }
}
