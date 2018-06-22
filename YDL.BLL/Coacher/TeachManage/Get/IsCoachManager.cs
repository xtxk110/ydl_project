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
    /// 是否为教练管理员
    /// </summary>
    public class IsCoachManager_187 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var obj = PermissionCheck.Instance.IsCoachManager(currentUser.Id);
            Response response = new Response();
            response.IsSuccess = true;
            response.Tag = obj;
            return response;
        }

    }
}
