using System;
using System.Linq;
using Newtonsoft.Json;
using System.Collections.Generic;
using YDL.Map;
using YDL.Utility;
using YDL.Model;
using YDL.Core;

namespace YDL.BLL
{
    /// <summary>
    /// 获取两队之间让分信息
    /// </summary>
    public class GetTeamsConcessionScore : IService
    {
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GameLoopDetail>>(request);

            var cmd = CommandHelper.CreateProcedure<GameLoopDetail>(FetchType.Fetch, "sp_GetTeamsConcessionScore");
            cmd.Params.Add(CommandHelper.CreateParam("@orderId", req.Filter.OrderId));
            cmd.Params.Add(CommandHelper.CreateParam("@user1Id", req.Filter.User1Id));
            cmd.Params.Add(CommandHelper.CreateParam("@user2Id", req.Filter.User2Id));
            var result = DbContext.GetInstance().Execute(cmd);

            return result;
        }
    }
}
