
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;

namespace YDL.BLL
{
    /// <summary>
    /// 获取账号绑定和安全相关信息(done)
    /// </summary>
    public class GetAccountBindSecurityInfo_187 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetUserRelatedFilter>>(request);
            var cmd = CommandHelper.CreateProcedure<User>(text: "sp_GetUser");
            cmd.Params.Add(CommandHelper.CreateParam("@userId", req.Filter.CurrentUserId));

            var result = DbContext.GetInstance().Execute(cmd);
            User user = result.FirstEntity<User>();
            user.CityId = user.CityIdCombine;
            //处理qq微信绑定状态相关
            DealQQWinXin(user);
            return result;

        }

        public void DealQQWinXin(User user)
        {
            if (!string.IsNullOrEmpty(user.WeiXinUnionId))
            {
                user.IsBindTXWeiXin = true;
            }
            if (!string.IsNullOrEmpty(user.QQOpenId))
            {
                user.IsBindQQ = true;
            }
            if (!string.IsNullOrEmpty(user.PayPassword))
            {
                user.IsSetPayPassword = true;
            }

            if (user.PayNoPwdAmount != 0)
            {
                user.IsEnablePayNoPwdAmount = true;
            }

        }
    }

}
