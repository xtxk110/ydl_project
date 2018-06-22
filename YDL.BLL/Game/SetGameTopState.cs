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
    /// 更新比赛置顶状态
    /// </summary>
    public class SetGameTopState : IService
    {
        /// <summary>
        /// 更新比赛置顶状态
        /// </summary>
        /// <param name="currentUser">忽略</param>
        /// <param name="request">Request.Game</param>
        /// <returns>Response.EmptyEntity</returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<Game>>(request);
            var game = req.Entities.FirstOrDefault();

            var cmd = CommandHelper.CreateProcedure(FetchType.Execute, "sp_SetGameTopState");
            cmd.Params.Add("@gameId", game.Id);
            cmd.Params.Add("@isTop", game.IsTop,DataType.Boolean);

            var result = DbContext.GetInstance().Execute(cmd);

            return result;
        }
    }
}
