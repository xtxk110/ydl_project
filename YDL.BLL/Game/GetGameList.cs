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
    /// 赛事列表
    /// </summary>
    public class GetGameList : IServiceBase
    {
        /// <summary>
        /// 赛事列表
        /// </summary>
        /// <param name="currentUser">忽略</param>
        /// <param name="request">Request.GetGameListFilter.Filter</param>
        /// <returns>Response.Game</returns>
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetGameListFilter>>(request);
            var result = GetGames(req, currentUser.Id);

            return result;
        }

        public static Response GetGames(Request<GetGameListFilter> req, string userId)
        {
            var cmd = CommandHelper.CreateProcedure<Game>(text: "sp_GetGameList");
            cmd.Params.Add(CommandHelper.CreateParam("@clubId", req.Filter.ClubId));
            cmd.Params.Add(CommandHelper.CreateParam("@cityId", req.Filter.CityId));
            cmd.Params.Add(CommandHelper.CreateParam("@gameName", req.Filter.GameName));
            cmd.Params.Add(CommandHelper.CreateParam("@isOnlySelf", req.Filter.IsOnlySelf));
            cmd.Params.Add(CommandHelper.CreateParam("@state", req.Filter.State));
            cmd.CreateParamPager(req.Filter);
            cmd.CreateParamUser(userId);

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();
            if (result.Entities.IsNotNullOrEmpty())
            {
                foreach (Game obj in result.Entities)
                {
                    SetGameTeamCount(obj);
                    obj.IsInLive = LiveHelper.Instance.IsInLive(obj.Id);
                }
            }

            return result;
        }

        private static void SetGameTeamCount(Game game)
        {
            var sql = "SELECT COUNT(1) FROM GameTeam WHERE GameId=@gameId";
            var cmd = CommandHelper.CreateText(FetchType.Scalar, sql);
            cmd.Params.Add("@gameId", game.Id);
            var result = DbContext.GetInstance().Execute(cmd);
            game.TeamCount = Convert.ToInt32(result.Tag);
        }
    }


    /// <summary>
    /// 赛事列表（游客模式）
    /// </summary>
    public class GetGameList2 : IService
    {
        /// <summary>
        /// 赛事列表
        /// </summary>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetGameListFilter>>(request);
            var result = GetGameList.GetGames(req, "tourist");

            return result;
        }
    }
}
