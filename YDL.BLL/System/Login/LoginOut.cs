using System.Collections.Generic;

using YDL.Core;
using YDL.Map;
using YDL.Model;
using Newtonsoft.Json;

namespace YDL.BLL
{
    /// <summary>
    /// 用户登录(done)
    /// </summary>
    public class LoginOut : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            CacheUserBuilder.Instance.LoginOut(currentUser.Id,currentUser.DeviceType);
            return ResultHelper.Success();
        }
    }
}
