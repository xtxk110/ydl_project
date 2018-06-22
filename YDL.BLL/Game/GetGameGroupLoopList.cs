using System;
using System.Linq;
using Newtonsoft.Json;
using System.Collections.Generic;
using YDL.Map;
using YDL.Model;
using YDL.Core;

namespace YDL.BLL
{
    /// <summary>
    /// 获取某个小组所有循环比赛场次
    /// </summary>
    public class GetGameGroupLoopList : IService
    {
        /// <summary>
        /// 获取某个小组所有循环比赛场次
        /// </summary>
        /// <param name="currentUser">忽略</param>
        /// <param name="request">Request.GameGroup.Filter</param>
        /// <returns>Response.GameLoop</returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GameGroup>>(request);
            var cmd = CommandHelper.CreateProcedure<GameLoop>(text: "sp_GetGameGroupLoopList");
            cmd.Params.Add(CommandHelper.CreateParam("@groupId", req.Filter.Id));
            cmd.Params.Add(CommandHelper.CreateParam("@gameId", req.Filter.GameId));
            var result = DbContext.GetInstance().Execute(cmd);

            return result;
        }
    }
}
