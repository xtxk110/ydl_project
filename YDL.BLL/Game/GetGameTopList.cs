using System;
using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Core;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 赛事列表
    /// </summary>
    public class GetGameTopList : IService
    {
        /// <summary>
        /// 赛事列表
        /// </summary>
        /// <param name="currentUser">忽略</param>
        /// <param name="request">Request.GetGameListFilter.Filter</param>
        /// <returns>Response.Game</returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<Game>>(request);
            var cmd = CommandHelper.CreateProcedure<Game>(text: "sp_GetGameTopList");
            cmd.Params.Add(CommandHelper.CreateParam("@cityId", req.Filter.CityId));

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();

            return result;
        }
    }

}
