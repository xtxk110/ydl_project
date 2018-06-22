using System;
using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Core;

namespace YDL.BLL
{
    /// <summary>
    /// 获取某次比赛与裁判相关的比赛对证列表（当前登录人是指定的裁判）
    /// </summary>
    public class GetGameJudgeLoopList : IServiceBase
    {
        /// <summary>
        /// 获取某次比赛与裁判相关的比赛对证列表（当前登录人是指定的裁判）
        /// </summary>
        /// <param name="currentUser">忽略</param>
        /// <param name="request">Request.Game.Filter</param>
        /// <returns>Response.GameLoop</returns>
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetGameJudgeLoopListFilter>>(request);
            var cmd = CommandHelper.CreateProcedure<GameLoop>(text: "sp_GetGameJudgeLoopList");
            cmd.Params.Add(CommandHelper.CreateParam("@gameId", req.Filter.Id));
            cmd.Params.Add(CommandHelper.CreateParam("@orderId", req.Filter.OrderId));
            cmd.Params.Add(CommandHelper.CreateParam("@judgeId", currentUser.Id));
            cmd.Params.Add(CommandHelper.CreateParam("@isNotFinish", req.Filter.IsNotFinish, DataType.Boolean));

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();

            return result;
        }

    }
}
