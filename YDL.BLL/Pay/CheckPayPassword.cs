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
    /// 检查支付密码是否正确
    /// </summary>
    public class CheckPayPassword : IService
    {

        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<User>>(request);
            var user = req.Entities.FirstOrDefault();
            string sql = @"
 SELECT * FROM dbo.UserAccount WHERE PayPassword=@PayPassword AND Id=@Id
";
            var cmd = CommandHelper.CreateText<User>(FetchType.Fetch, sql);
            cmd.Params.Add("@PayPassword", user.PayPassword);
            cmd.Params.Add("@Id", user.Id);

            var result = DbContext.GetInstance().Execute(cmd);

            if (result.Entities.Count > 0)
            {
                result.Entities.Clear();
                return result;
            }
            else
            {
                return ResultHelper.Fail("支付密码错误,请重新输入");
            }
        }
    }

}
