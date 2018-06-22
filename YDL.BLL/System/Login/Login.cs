using System.Collections.Generic;
using System;

using YDL.Core;
using YDL.Utility;
using YDL.Map;
using YDL.Model;
using Newtonsoft.Json;

namespace YDL.BLL
{
    /// <summary>
    /// 用户登录
    /// </summary>
    public class Login : IService
    {
        /// <summary>
        /// 用户登录(done)
        /// </summary>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<User>>(request);
            var temp = req.Filter;

            ////移动内部测试版本,PC版本跳过版本验证
            //if (!req.IsInnerTest && temp.DeviceType != DeviceType.PC)
            //{
            //    if (temp.DeviceVersion.IsNullOrEmpty())
            //    {
            //        return ResultHelper.Fail("没有附加版本号。");
            //    }
            //    else if (SystemHelper.HasNewVersion(temp.DeviceType, temp.DeviceVersion))
            //    {
            //        return ResultHelper.Fail(ErrorCode.NEW_VERSION, "发现新版本，请更新。");
            //    }
            //}

            //登录验证
            var user = CacheUserBuilder.Instance.Login(temp.Code, temp.Password, temp.DeviceType);
            if (user != null)
            {
                user.UserLimit = UserHelper.GetUserLimit(user.Id);
                user.Config = UserHelper.GetConfig();
                user.userId = user.Id;
                user.LoginType = SystemDic.YDL_LOGIN;
                user.LimitList = GetLimitByUser_196.GetLimitList(user.Id);

                //获取IM TOKEN
                IMToken token = new IMToken();
                token.UserSig = IMUserSig.GetUserSig(user.Code);
                token.Sdkappid = IMRequest.sdkappid;
                token.AccountType = IMRequest.AccountType;
                token.Identifier = user.Code;
                user.ImToken = token;
            }
            Response result = ResultHelper.Success(new List<EntityBase> { user });
          
            return result;
        }
    }
}
