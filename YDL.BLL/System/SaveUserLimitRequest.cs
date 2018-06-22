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
    /// 保存用户权限请求(审核通过也调用本接口，设置IsProcessed=true)
    /// </summary>
    public class SaveUserLimitRequest : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<UserLimitRequest>>(request);
            var note = req.Entities.FirstOrDefault();

            List<EntityBase> entites = new List<EntityBase>();
            entites.Add(note);
            if (note.RowState == RowState.Added)
            {
                note.TrySetNewEntity();
            }

            if (note.IsProcessed) {
                var limit = UserHelper.GetUserLimit(note.Id);
                limit.IsActivity = note.IsActivity;
                limit.IsClub = note.IsClub;
                limit.IsGame = note.IsGame;
                limit.IsNote = note.IsNote;
                limit.IsVenue = note.IsVenue;
                limit.SetRowModified();
                entites.Add(limit);
            }
            return DbContext.GetInstance().Execute(CommandHelper.CreateSave(entites));
        }

    }

}
