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
    /// 微信登陆时 通过手机创建ydl账户, 并绑定微信UnionId , 或者将UnionId 绑定到已有的ydl账户
    /// 此接口命名没命好,应该叫: SaveWeixinUnionIdByMobile
    /// done
    /// </summary>
    public class BindMobileForWinXinLogin_184 : IService
    {

        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetUserRelatedFilter>>(request);
            //查询此手机号是否存在
            var result = getUserByMobile(req.Filter.Mobile);
            if (result.Entities.Count == 0)
            {
                //不存在手机号就创建一个悦动力账户并返回
                result = createUser(req);
            }
            else
            {
                //存在手机号就将unionId存到这条记录上
                string userid = result.FirstEntity<User>().Id;
                updateUserSetUnionId(userid, req.Filter.WeiXinUnionId);
            }
            var userFinal = result.FirstEntity<User>();
            userFinal.LoginType = SystemDic.WEIXIN_LOGIN;
            return result;
        }



        private Response createUser(Request<GetUserRelatedFilter> req)
        {
            User user = new User();
            user.PetName = req.Filter.PetName;
            user.Sex = req.Filter.Sex;
            user.Password = "default_" + Ext.NewId(); //给默认密码
            user.Password = user.Password.Substring(0, user.Password.Length - 8);
            user.WeiXinUnionId = req.Filter.WeiXinUnionId;
            user.HeadUrl = req.Filter.HeadUrl;
            user.Mobile = req.Filter.Mobile;
            Response rsp = new Response();
            if (!string.IsNullOrEmpty(req.Filter.WeiXinUnionId))
            {
                rsp = new SaveQuickUser().RegisterUser(user);
                user.Code = rsp.Tag.ToString();
                rsp.Entities.Clear();
                rsp.Entities.Add(user);
            }
            else
            {
                rsp.IsSuccess = false;
                rsp.Message = "创建用户失败";
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

        private Response updateUserSetUnionId(string userid, string unionId)
        {
            var sql = @"UPDATE dbo.UserAccount SET WeiXinUnionId=@WeiXinUnionId WHERE Id=@Id";
            var cmd = CommandHelper.CreateText<ClubUser>(FetchType.Execute, sql);
            cmd.Params.Add("@WeiXinUnionId", unionId);
            cmd.Params.Add("@Id", userid);

            var result = DbContext.GetInstance().Execute(cmd);
            return result;
        }
    }

}
