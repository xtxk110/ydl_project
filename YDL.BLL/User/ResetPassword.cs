using System;
using System.Collections.Generic;
using System.Linq;

using Newtonsoft.Json;
using YDL.Core;
using YDL.Map;
using YDL.Model;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 重置密码
    /// </summary>
    public class ResetPassword : IService
    {
        /// <summary>
        /// 重置密码(done)
        /// </summary>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<User>>(request);
            var user = req.Entities.FirstOrDefault();

            if (user.ValCode.IsNullOrEmpty() || user.Password.IsNullOrEmpty())
            {
                return ResultHelper.Fail("请输入新密码和验证码。");
            }

            var valCode = SystemHelper.GetValCode(user.Mobile);
            if (valCode == null || user.ValCode != valCode.Code)
            {
                return ResultHelper.Fail("验证码错误。");
            }

            var dbuser = UserHelper.GetUserByMobile(user.Mobile);
            if (dbuser==null)
            {
                return ResultHelper.Fail("你的手机号没有注册,请先注册");
            }

            var cmd = CommandHelper.CreateText(FetchType.Execute, "UPDATE UserAccount SET Password=@password WHERE Mobile=@Mobile ");
            cmd.Params.Add("@Mobile", user.Mobile);
            cmd.Params.Add("@password", user.Password);

            return DbContext.GetInstance().Execute(cmd);
        }
    }

}
