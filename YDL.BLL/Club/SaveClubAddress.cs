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
    /// 保存常用活动场地
    /// </summary>
    public class SaveClubAddress : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<ClubAddress>>(request);

            List<EntityBase> entites = new List<EntityBase>();
            var cmd = CommandHelper.CreateSave(entites);

            foreach (ClubAddress obj in req.Entities)
            {
                if (obj.RowState == RowState.Added)
                {
                    obj.SetCreateDate();
                }
                entites.Add(obj);
            }

            return DbContext.GetInstance().Execute(cmd);
        }
    }

}
