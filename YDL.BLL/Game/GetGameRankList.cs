using System;
using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Core;

namespace YDL.BLL
{
    /// <summary>
    /// 获取比赛名次列表
    /// </summary>
    public class GetGameRankList : IService
    {
        /// <summary>
        /// 获取比赛名次列表
        /// </summary>
        /// <param name="currentUser">忽略</param>
        /// <param name="request">Request.GetGameRankList.Filter</param>
        /// <returns>Response.GameTeam</returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<Game>>(request);
            var cmd = CommandHelper.CreateProcedure<GameTeam>(text: "sp_GetGameRankList");
            cmd.Params.Add("@gameId", req.Filter.Id);
            cmd.Params.Add("@knockOutAB", string.IsNullOrEmpty(req.Filter.KnockOutAB)?"A": req.Filter.KnockOutAB);
            cmd.CreateParamMsg();

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();

            return result;
        }

    }


}
