
using Newtonsoft.Json;
using RestSharp;
using System;
using System.Linq;
using YDL.Map;
using YDL.Model;

namespace YDL.BLL
{
    /// <summary>
    /// 根据UserId获取单个用户信息(done)
    /// </summary>
    public class GetUser : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetUserRelatedFilter>>(request);
            var result = UserHelper.Instance.GetUserInfo(req.Filter.Id
                    , req.Filter.CurrentUserId
                    , req.Filter.ClubId, req.Filter.UserCode);
            return result;
        }


    }

}
