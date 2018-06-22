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
using System.Net;
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;
using System.Web;

namespace YDL.BLL
{

    /// <summary>
    /// QQ登陆时 通过手机创建ydl账户, 并绑定QQ OpenId, 或者将OpenId 绑定到已有的ydl账户
    ///  此接口命名没命好,应该叫: SaveQQOpenIdByMobile
    ///  done
    /// </summary>
    public class BindMobileForQQLogin_184 : IService
    {

        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetUserRelatedFilter>>(request);
            //查询此手机号是否存在
            var result = getUserByMobile(req.Filter.Mobile);
            if (result.Entities.Count == 0)
            {
                //不存在就创建一个悦动力账户并返回
                result = createUser(req);
            }
            else
            {
                //存在就将openid存到这条记录上
                string userid = result.FirstEntity<User>().Id;
                updateUserSetOpenId(userid, req.Filter.QQOpenId);
            }

            var userFinal = result.FirstEntity<User>();
            userFinal.LoginType = SystemDic.QQ_LOGIN;
            return result;
        }



        private Response createUser(Request<GetUserRelatedFilter> req)
        {
            string QQOpenId = req.Filter.QQOpenId;
            User user = new User();
            user.PetName = req.Filter.PetName;
            user.Password = "default_" + Ext.NewId(); //给默认密码
            user.Password = user.Password.Substring(0, user.Password.Length - 8);
            user.Sex = req.Filter.Sex;
            user.Mobile = req.Filter.Mobile;
            user.QQOpenId = QQOpenId;
            user.HeadUrl = SystemHelper.Instance.DownloadImageFromURL(req.Filter.HeadUrl);
            Response rsp = new Response();
            if (!string.IsNullOrEmpty(QQOpenId) && !string.IsNullOrEmpty(req.Filter.PetName))
            {
                rsp = new SaveQuickUser().RegisterUser(user);
                user.Code = rsp.Tag.ToString();
                rsp.Entities.Clear();
                rsp.Entities.Add(user);
            }
            else
            {
                rsp.IsSuccess = false;
                rsp.Message = "登陆失败";
            }

            return rsp;
        }





        private Response getUserByMobile(string Mobile)
        {
            string sql = @"
SELECT * FROM dbo.UserAccount WHERE Mobile=@Mobile
";
            var cmd = CommandHelper.CreateText<User>(FetchType.Fetch, sql);
            cmd.Params.Add("@Mobile", Mobile);
            var result = DbContext.GetInstance().Execute(cmd);
            return result;
        }

        private Response updateUserSetOpenId(string userid, string OpenId)
        {
            var sql = @"UPDATE dbo.UserAccount SET QQOpenId=@QQOpenId WHERE Id=@Id ";
            var cmd = CommandHelper.CreateText<ClubUser>(FetchType.Execute, sql);
            cmd.Params.Add("@QQOpenId", OpenId);
            cmd.Params.Add("@Id", userid);

            var result = DbContext.GetInstance().Execute(cmd);
            return result;
        }
    }

}
