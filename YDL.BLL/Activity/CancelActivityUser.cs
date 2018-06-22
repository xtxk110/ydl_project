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
    /// 移除活动成员
    /// </summary>
    public class CancelActivityUser : IServiceBase
    {
        /// <summary>
        /// 移除活动成员
        /// </summary>
        /// <param name="currentUser">Request<ActivityUser></param>
        /// <param name="request"></param>
        /// <returns>Response<EmptyEntity></returns>
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<ActivityUser>>(request);
            var obj = req.Entities.FirstOrDefault();
            obj.SetRowDeleted();
            var cmd = CommandHelper.CreateSave(req.Entities);
            return DbContext.GetInstance().Execute(cmd);
        }

    }

}
