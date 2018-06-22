using System.Text;
using System.Collections.Generic;

using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Utility;
using YDL.Core;

namespace YDL.BLL
{
    /// <summary>
    /// 获取单个场馆信息
    /// </summary>
    public class GetVenue : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<Venue>>(request);

            var cmd = CommandHelper.CreateProcedure<Venue>(text: "sp_GetVenue");
            cmd.Params.Add(CommandHelper.CreateParam("@venueId", req.Filter.Id));
            cmd.Params.Add(CommandHelper.CreateParam("@isGetMyRole", req.Filter.IsGetMyRole, DataType.Boolean));
            cmd.Params.Add(CommandHelper.CreateParam("@curUser", currentUser.Id));
            cmd.Params.Add(CommandHelper.CreateParam("@curUserLng", req.Filter.CurUserLng, DataType.Double));
            cmd.Params.Add(CommandHelper.CreateParam("@curUserLat", req.Filter.CurUserLat, DataType.Double));
            var result = DbContext.GetInstance().Execute(cmd);

            var obj = result.FirstEntity<Venue>();
            if (obj != null)
            {
                obj.TryGetFiles();
                obj.IsFavorite = CurrentUserIsFavoriteVenue(req.Filter.Id, currentUser.Id);
            }

            return result;
        }

        public bool CurrentUserIsFavoriteVenue(string favoriteId, string userId)
        {

            string sql = @"
 SELECT Id FROM CoachUserFavorite  WHERE UserId=@UserId AND FavoriteId=@FavoriteId
";
            var cmd = CommandHelper.CreateText<Coacher>(FetchType.Fetch, sql);
            cmd.Params.Add("@FavoriteId", favoriteId);
            cmd.Params.Add("@UserId", userId);

            var result = DbContext.GetInstance().Execute(cmd);
            if (result.Entities.Count > 0)
            {
                return true;
            }
            else
            {
                return false;
            }


        }


    }

}
