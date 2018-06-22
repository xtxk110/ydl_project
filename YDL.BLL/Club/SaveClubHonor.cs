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
 
    public class SaveClubHonor : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<ClubHonor>>(request);

            List<EntityBase> entites = new List<EntityBase>();
            foreach (ClubHonor obj in req.Entities)
            {
                obj.TrySetNewEntity();
                entites.Add(obj);
            }
            var cmd = CommandHelper.CreateSave(entites);
            return DbContext.GetInstance().Execute(cmd);
        }
    }

}
