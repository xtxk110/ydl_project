
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;

namespace YDL.BLL
{
    /// <summary>
    /// 根据user code获取用户信息
    /// (此接口跟GetUser 接口是一样的, 
    /// 唯一不同是 这里传的是UserCode, GetUser 传的是 user 实体的Id, 其他入参是一样的)
    /// (done)
    /// </summary>
    public class GetUserInfoByCode : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetUserRelatedFilter>>(request);
            var user = UserHelper.GetUserByCode(req.Filter.UserCode);
            if (user==null)
            {
                return ResultHelper.Fail("没有找到此用户");
            }
            var result = UserHelper.Instance.GetUserInfo(user.Id, req.Filter.CurrentUserId
                 , req.Filter.ClubId, req.Filter.UserCode);
            return result;

        }
    }

}
