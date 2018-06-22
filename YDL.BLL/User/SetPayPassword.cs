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
    /// 设置支付密码
    /// </summary>
    public class SetPayPassword : IService
    {
   
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<User>>(request);
            var user = req.Entities.FirstOrDefault();

            if (user.Id.IsNullOrEmpty() || user.PayPassword.IsNullOrEmpty())
            {
                return ResultHelper.Fail("请输入新支付密码。");
            }

            var sql = @"UPDATE dbo.UserAccount SET PayPassword=@PayPassword WHERE Id=@Id ";
            var cmd = CommandHelper.CreateText<ClubUser>(FetchType.Execute, sql);
            cmd.Params.Add("@PayPassword", user.PayPassword);
            cmd.Params.Add("@Id", user.Id);

            var result = DbContext.GetInstance().Execute(cmd);
            return result;
        }
    }

}
