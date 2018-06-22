using System;
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
    /// 尝试结束一个大轮次，不自动进入下一轮（用户手工操作）
    /// </summary>
    public class FinishGameOrder : IService
    {
        /// <summary>
        /// 尝试结束一个大轮次，不自动进入下一轮（用户手工操作）
        /// </summary>
        /// <param name="currentUser">忽略</param>
        /// <param name="request">Request.GameOrder.Entities</param>
        /// <returns>Response.EmptyEntity</returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GameOrder>>(request);

            var cmd = CommandHelper.CreateProcedure(FetchType.Scalar, "sp_FinishGameOrder");
            cmd.Params.Add(CommandHelper.CreateParam("@orderId", req.Entities.First().Id));
            var result = DbContext.GetInstance().Execute(cmd);

            return (int)result.Tag == 0 ? ResultHelper.Success() : ResultHelper.Fail("本轮还存在未结束的场次比赛，无法结束.");
        }
    }
}
