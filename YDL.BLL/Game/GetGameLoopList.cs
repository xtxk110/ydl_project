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
    /// 获取比赛列表
    /// </summary>
    public class GetGameLoopList : IService
    {
        /// <summary>
        /// 获取比赛列表
        /// </summary>
        /// <param name="currentUser">忽略</param>
        /// <param name="request">Request.Game.Filter</param>
        /// <returns>Response.GameLoop</returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetGameLoopListFilter>>(request);
            var cmd = CommandHelper.CreateProcedure<GameLoop>(text: "sp_GetGameLoopList");
            cmd.Params.Add(CommandHelper.CreateParam("@gameId", req.Filter.GameId));
            cmd.Params.Add(CommandHelper.CreateParam("@teamName", req.Filter.TeamName));
            cmd.Params.Add(CommandHelper.CreateParam("@tableNo", req.Filter.TableNo, DataType.Int32));
            cmd.Params.Add(CommandHelper.CreateParam("@state", req.Filter.State));
            cmd.Params.Add(CommandHelper.CreateParam("@beginTime", req.Filter.BeginTime.ToDbDateTimeString()));
            cmd.CreateParamPager(req.Filter);

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();

            return result;
        }

    }
}
