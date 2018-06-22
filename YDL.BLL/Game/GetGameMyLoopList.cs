using System;
using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Core;

namespace YDL.BLL
{
    /// <summary>
    /// 获取某次比赛与自己有关的轮次对阵比赛
    /// </summary>
    public class GetGameMyLoopList : IServiceBase
    {
        /// <summary>
        /// 获取某次比赛与自己有关的轮次对阵比赛
        /// </summary>
        /// <param name="currentUser">忽略</param>
        /// <param name="request">Request.Game.Filter</param>
        /// <returns>Response.GameLoop</returns>
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<Game>>(request);
            var cmd = CommandHelper.CreateProcedure<GameLoop>(text: "sp_GetGameMyLoopList");
            cmd.Params.Add(CommandHelper.CreateParam("@GameId", req.Filter.Id));
            cmd.CreateParamUser(currentUser.Id);

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();

            return result;
        }

    }
}
