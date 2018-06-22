using System;
using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Core;

namespace YDL.BLL
{
    /// <summary>
    /// 获取比赛报名队列表
    /// </summary>
    public class GetGameTeamList : IService
    {
        /// <summary>
        /// 获取比赛报名队列表(包含排名,积分,轮次)
        /// </summary>
        /// <param name="currentUser">忽略</param>
        /// <param name="request">Request.GetGameTeamListFilter.Filter</param>
        /// <returns>Response.GameTeam</returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetGameTeamListFilter>>(request);

            //var cmd = CommandHelper.CreateProcedure<GameTeam>(text: "sp_GetGameTeamList1");
            //cmd.Params.Add(CommandHelper.CreateParam("@GameId", req.Filter.GameId));
            //cmd.Params.Add(CommandHelper.CreateParam("@teamName", req.Filter.TeamName));

            //var result = DbContext.GetInstance().Execute(cmd);
            //return result;
            
            return GameHelper.GetGameTeamList(req.Filter);
           
        }

    }

    
}
