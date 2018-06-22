using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;

using Newtonsoft.Json;
using YDL.Core;
using YDL.Map;
using YDL.Model;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 验证手机验证码 done
    /// </summary>
    public class CheckMobileCode : IService
    {

        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<User>>(request);
            var user = req.Entities.FirstOrDefault();

            //验证版本号//登录时不检查版本  ZQ20180327
            //if (user.DeviceType != DeviceType.PC)
            //{
            //    if (user.DeviceVersion.IsNullOrEmpty())
            //    {
            //        return ResultHelper.Fail("没有附加版本号。");
            //    }
            //    else if (SystemHelper.HasNewVersion(user.DeviceType, user.DeviceVersion))
            //    {
            //        return ResultHelper.Fail(ErrorCode.NEW_VERSION, "发现新版本，请更新。");
            //    }
            //}

            //验证手机验证码
            if (user.Mobile.IsNullOrEmpty() || user.ValCode.IsNullOrEmpty())
            {
                return ResultHelper.Fail("请输入手机，验证码。");
            }

            var valCode = SystemHelper.GetValCode(user.Mobile);
            if (valCode == null || user.ValCode != valCode.Code)
            {
                return ResultHelper.Fail("验证码错误。");
            }

            return ResultHelper.Success();
        }

    }

}
