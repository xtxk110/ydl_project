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
    /// 活动报名
    /// </summary>
    public class SaveActivityUser : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<ActivityUser>>(request);
            var activityUser = req.Entities.FirstOrDefault();
            return ActivityHelper.ActivitySignUp(activityUser);
        }
    }
}
