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
    /// 获取淘汰赛阶段比率列表
    /// </summary>
    public class GetGameKnockLoopList : IServiceBase
    {
        /// <summary>
        /// 获取淘汰赛阶段比率列表
        /// </summary>
        /// <param name="currentUser">忽略</param>
        /// <param name="request">Request.Game.Filter</param>
        /// <returns>Response.GameLoop</returns>
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<Game>>(request);
            var cmd = CommandHelper.CreateProcedure<GameLoop>(text: "sp_GetGameKnockLoopList");
            cmd.Params.Add(CommandHelper.CreateParam("@gameId", req.Filter.Id));
            cmd.Params.Add(CommandHelper.CreateParam("@knockOutAB", req.Filter.KnockOutAB.IsNullOrEmpty() ? KnockOutAB.A : req.Filter.KnockOutAB));

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();

            return result;
        }

    }
}
