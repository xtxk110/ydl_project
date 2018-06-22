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
    /// 更新单场比赛状态
    /// </summary>
    public class SetGameLoopState : IService
    {
        /// <summary>
        /// 更新单场比赛状态
        /// </summary>
        /// <param name="currentUser">忽略</param>
        /// <param name="request">Request.GameLoop</param>
        /// <returns>Response.EmptyEntity</returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GameLoop>>(request);
            var gameLoop = req.Entities.FirstOrDefault();

            var cmd = CommandHelper.CreateProcedure(FetchType.Execute, "sp_SetGameLoopState");
            cmd.Params.Add("@loopId", gameLoop.Id);
            cmd.Params.Add("@state", gameLoop.State);

            var result = DbContext.GetInstance().Execute(cmd);

            return result;
        }
    }
}
