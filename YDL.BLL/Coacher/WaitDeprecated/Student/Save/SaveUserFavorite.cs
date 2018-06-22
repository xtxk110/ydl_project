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
    /// 保存用户收藏
    /// </summary>
    public class SaveUserFavorite : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<CoachUserFavorite>>(request);
            var obj = req.FirstEntity();
            if (IsExistFavoriteId(obj) && obj.RowState == RowState.Added)
            {
                return ResultHelper.Fail("已收藏过, 不能再收藏");
            }

            List<EntityBase> entites = new List<EntityBase>();
            entites.Add(obj);

            if (obj.RowState == RowState.Added)
            {
                obj.TrySetNewEntity();
            }

            var result = DbContext.GetInstance().Execute(CommandHelper.CreateSave(entites));
            return result;

        }

        public bool IsExistFavoriteId(CoachUserFavorite obj)
        {
            string sql = @"
  SELECT Id FROM CoachUserFavorite  WHERE UserId=@UserId AND FavoriteId=@FavoriteId
";
            var cmd = CommandHelper.CreateText<Coacher>(FetchType.Fetch, sql);
            cmd.Params.Add("@UserId", obj.UserId);
            cmd.Params.Add("@FavoriteId", obj.FavoriteId);

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
