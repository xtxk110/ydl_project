using System.Text;
using System.Collections.Generic;

using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Utility;
using YDL.Core;
using System.Configuration;
using RestSharp;
using System;

namespace YDL.BLL
{
    /// <summary>
    /// 此接口用于 qq登陆ydl app (done)
    /// 业务逻辑: 
    ///     如果通过QQOpenId 查询ydl账户存在就直接去登陆
    ///     如果不存在ydl账户就返回GoBindMobile 标识, 前端再调用 BindMobileForQQLogin_184 接口创建ydl账户
    /// </summary>
    public class GetQQLoginInfo_184 : IService
    {
        public static string appid = ConfigurationManager.AppSettings["appid"];
        public static string secret = ConfigurationManager.AppSettings["secret"];

        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetUserRelatedFilter>>(request);
            //通过QQOpenId查询数据库看ydl账户是否存在
            var result = getUserByQQOpenId(req.Filter.QQOpenId);
            var userFinal = result.FirstEntity<User>() ?? new User();
            userFinal.LoginType = SystemDic.QQ_LOGIN;
            if (result.Entities.Count == 0)//不存在ydl账号
            {
                userFinal.ThirdPartyLoginState = "GoBindMobile";
                result.Entities.Add(userFinal);
            }
            else //存在ydl账号
            {
                if (!string.IsNullOrEmpty(userFinal.Mobile))//并且有手机号,直接去登陆
                {
                    userFinal.ThirdPartyLoginState = "GoLogin";
                }
               
            }
         
          

         
            return result;
        }




        private Response getUserByQQOpenId(string QQOpenId)
        {
            string sql = @"
SELECT * FROM dbo.UserAccount WHERE QQOpenId=@QQOpenId
";
            var cmd = CommandHelper.CreateText<User>(FetchType.Fetch, sql);
            cmd.Params.Add("@QQOpenId", QQOpenId);
            var result = DbContext.GetInstance().Execute(cmd);
            return result;
        }
    }

}
