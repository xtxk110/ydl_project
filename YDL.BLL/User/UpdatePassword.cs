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
    /// 修改密码 done
    /// </summary>
    public class UpdatePassword : IService
    {
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<User>>(request);
            var user = req.Entities.FirstOrDefault();

            if (user.Id.IsNullOrEmpty() || user.Password.IsNullOrEmpty())
            {
                return ResultHelper.Fail("请输入新密码。");
            }

            var sql = @"UPDATE dbo.UserAccount SET Password=@Password WHERE Id=@Id ";
            var cmd = CommandHelper.CreateText<ClubUser>(FetchType.Execute, sql);
            cmd.Params.Add("@Password", user.Password);
            cmd.Params.Add("@Id", user.Id);

            var result = DbContext.GetInstance().Execute(cmd);
            return result;
        }
    }

}
