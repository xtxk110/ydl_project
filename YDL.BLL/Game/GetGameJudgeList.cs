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
    /// 获取比赛裁判列表
    /// </summary>
    public class GetGameJudgeList : IService
    {
        /// <summary>
        /// 获取比赛裁判列表
        /// </summary>
        /// <param name="currentUser">忽略</param>
        /// <param name="request">Request.Game.Filter</param>
        /// <returns>Response.GameJudge</returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<Game>>(request);
            var cmd = CommandHelper.CreateProcedure<GameJudge>(text: "sp_GetGameJudgeList");
            cmd.Params.Add("@gameId", req.Filter.Id);

            return DbContext.GetInstance().Execute(cmd);
        }

    }
}
