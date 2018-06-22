using System;
using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Core;
using YDL.Utility;
using System.Collections.Generic;
using System.Threading;
using System.Configuration;

namespace YDL.BLL
{

    public class ConvertPasswordToMD5_184 : IService
    {
        public Response Execute(string request)
        {
            string CanExecuteTempAPI = ConfigurationManager.AppSettings["CanExecuteTempAPI"];
            if (CanExecuteTempAPI != "1")
            {
                return ResultHelper.Fail("你没有执行权限");
            }

            var sql = @"
 SELECT  * FROM dbo.UserAccount   ORDER BY CreateDate 
";
            var cmd = CommandHelper.CreateText<User>(FetchType.Fetch, sql);
            var result = DbContext.GetInstance().Execute(cmd);

            Response rsp = new Response();

            var logger = LoggerHelper.GetOperateLog();

            foreach (var item in result.Entities)
            {
                var user = item as User;
                if (user.Password.Length != 32)
                {
                    rsp = ConvertPwdToMD5(user);
                    if (rsp.IsSuccess == false)
                    {
                        logger.Error("密码转换失败 ,账号: " + user.Code + "  " + rsp.Message);
                        return rsp;
                    }
                }

                if (user.PayPassword != null && user.PayPassword.Length != 32)
                {
                    rsp = ConvertPayPwdToMD5(user);
                    if (rsp.IsSuccess == false)
                    {
                        logger.Error("密码转换失败 ,账号: " + user.Code + "  " + rsp.Message);
                        return rsp;
                    }
                }

                logger.Debug("密码转换成功, 账号: " + user.Code);
                Thread.Sleep(10);
            }

            return rsp;

        }

        public Response ConvertPwdToMD5(User obj)
        {
            var sql = @"UPDATE dbo.UserAccount SET Password=@Password WHERE Id=@Id ";
            var cmd = CommandHelper.CreateText<ClubUser>(FetchType.Execute, sql);
            cmd.Params.Add("@Password", obj.Password.EncryptByMD5());

            cmd.Params.Add("@Id", obj.Id);

            var result = DbContext.GetInstance().Execute(cmd);
            return result;
        }

        public Response ConvertPayPwdToMD5(User obj)
        {
            var sql = @"UPDATE dbo.UserAccount SET PayPassword=@PayPassword WHERE Id=@Id ";
            var cmd = CommandHelper.CreateText<ClubUser>(FetchType.Execute, sql);
            cmd.Params.Add("@PayPassword", obj.PayPassword.EncryptByMD5());
            cmd.Params.Add("@Id", obj.Id);

            var result = DbContext.GetInstance().Execute(cmd);
            return result;
        }



    }
}
