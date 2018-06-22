using System.Collections.Generic;

using Newtonsoft.Json;
using YDL.Map;
using YDL.Core;
using YDL.Model;

namespace YDL.BLL
{
    /// <summary>
    /// 根据用户code 获取用户信息
    /// </summary>
    public class GetUserByCode : IService
    {
 
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<User>>(request);
            var user = UserHelper.GetUserByCode(req.Filter.Code);
            if (user == null) {
                return ResultHelper.Fail("帐号不存在。");
            }


            return ResultHelper.Success(new List<EntityBase> { user });
        }
    }

}
