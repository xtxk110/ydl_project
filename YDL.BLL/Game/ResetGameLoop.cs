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
    /// 重置比分
    /// </summary>
    public class ResetGameLoop : IService
    {
        /// <summary>
        /// 重置比分
        /// </summary>
        /// <param name="request">Request.GameTeam.Filter</param>
        /// <returns>Response.GameTeam</returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GameLoop>>(request);
            var cmd = CommandHelper.CreateProcedure(fetchType: FetchType.Execute, text: "sp_ResetGameLoop");
            cmd.Params.Add(CommandHelper.CreateParam("@loopId", req.Filter.Id));

            var result = DbContext.GetInstance().Execute(cmd);

            return result;
        }

    }
}
