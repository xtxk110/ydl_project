using System;
using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Core;
using YDL.Utility;
using System.Collections.Generic;

namespace YDL.BLL
{
    /// <summary>
    /// 取消用户收藏
    /// </summary>
    public class CancelUserFavorite : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<CoachUserFavorite>>(request);
            var obj = req.FirstEntity();
            var sql = @" 
DELETE FROM  CoachUserFavorite  WHERE UserId=@UserId AND FavoriteId=@FavoriteId
";

            var cmd = CommandHelper.CreateText<ClubUser>(FetchType.Execute, sql);
            cmd.Params.Add("@UserId", obj.UserId);
            cmd.Params.Add("@FavoriteId", obj.FavoriteId);

            var result = DbContext.GetInstance().Execute(cmd);
            return result;

        }



    }
}
