using System.Collections.Generic;
using System;
using System.Runtime.Caching;

using YDL.Core;
using YDL.Utility;
using YDL.Map;
using YDL.Model;
using Newtonsoft.Json;

namespace YDL.BLL
{
    /// <summary>
    /// 发送短信验证码
    /// </summary>
    public class SendSmsValCode : IService
    {
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<User>>(request);

            if (req.Filter.Id.IsNotNullOrEmpty() && req.Filter.Mobile.IsNullOrEmpty())
            {
                User temp = UserHelper.GetUserById(req.Filter.Id);
                if (temp != null)
                {
                    req.Filter.Mobile = temp.Mobile;
                }
            }

            if (req.Filter.Mobile.IsNotNullOrEmpty())
            {
                ValCode val = new ValCode();
                string code = val.CreateValidateCode(4);

                var cmd = CommandHelper.CreateProcedure(FetchType.Execute, "sp_UpdateValCode");
                cmd.Params.Add("@mobile", req.Filter.Mobile);
                cmd.Params.Add("@code", code);
                var result = DbContext.GetInstance().Execute(cmd);

                if(!result.IsSuccess)
                    return ResultHelper.Fail("发送验证码失败。");


                var sendResult = SmsHelper.SendValCode(req.Filter.Mobile, code);
                if (sendResult.result == 0)
                {
                    return ResultHelper.Success("发送成功。");
                }
                else
                {
                    return ResultHelper.Fail(string.Format("发送验证码失败，错误代码：{0}。", sendResult.errMsg));
                }
            }
            else
            {
                return ResultHelper.Fail("请输入手机号码。");
            }
        }
    }
}
