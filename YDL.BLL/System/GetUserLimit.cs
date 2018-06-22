using System.Text;
using System.Collections.Generic;

using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 获取用户权限，单个需传递UserId(done)
    /// </summary>
    public class GetUserLimit : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<UserLimit>>(request);
            var result = ResultHelper.Success();
            var limit = UserHelper.GetUserLimit(req.Filter.UserId);
            if (limit != null)
            {
                result.Entities = new List<Core.EntityBase> { limit };
            }
            return result;
        }
    }
}
