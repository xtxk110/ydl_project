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
    /// 保存用户权限(done)
    /// </summary>
    public class SaveUserLimit : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<UserLimit>>(request);
            var obj = req.Entities.FirstOrDefault();

            obj.UserId = obj.UserId.GetId();

            var limit = UserHelper.GetUserLimit(obj.UserId);
            if (limit != null)
            {
                obj.SetRowModified();
            }
            else
            {
                obj.SetNewEntity();
                obj.Id = obj.UserId.GetId();
            }

            return DbContext.GetInstance().Execute(CommandHelper.CreateSave(req.Entities));
        }

    }

}
