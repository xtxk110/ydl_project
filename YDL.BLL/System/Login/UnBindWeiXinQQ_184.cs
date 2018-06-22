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
    /// 此接口用于, 用户详情界面解除 qq 微信 (done)
    /// </summary>
    public class UnBindWeiXinQQ_184 : IService
    {

        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetUserRelatedFilter>>(request);
            var user = UserHelper.GetUserById(req.Filter.UserId);
            var result = new Response();
            if (req.Filter.UnBindType=="QQ")
            {
                result=UnBindQQ(req,user);
            }
            else if(req.Filter.UnBindType == "WeiXin")
            {
                result = UnBindWeiXin(req, user);
            }

            return result;
        }

        private Response UnBindQQ(Request<GetUserRelatedFilter> req, User user)
        {
            //解绑逻辑: 
            //1.微信未解绑,直接解绑qq即可
            //2.微信已解绑,即要切回原始ydl账户.下面情况都满足才能切回
            //  2.1.补全手机号
            //  2.2.默认密码修改了
            if (string.IsNullOrEmpty(user.WeiXinUnionId))
            {

                if (string.IsNullOrEmpty(user.Mobile))
                {
                    return ResultHelper.Fail("请绑定手机号后再解绑");
                }
                if (user.Password.Contains("default") && user.Password.Length == 32)
                {
                    //默认系统生成的密码需要修改
                    return ResultHelper.Fail("请修改密码后再解绑");
                }
            }

            //解绑QQ
            return updateUserSetOpenId("", req.Filter.UserId);
        }

        private Response UnBindWeiXin(Request<GetUserRelatedFilter> req, User user)
        {
            //解绑逻辑: 同UnBindQQ 方法
            if (string.IsNullOrEmpty(user.QQOpenId))
            {

                if (string.IsNullOrEmpty(user.Mobile))
                {
                    return ResultHelper.Fail("请绑定手机号后再解绑");
                }
                if (user.Password.Contains("default") && user.Password.Length == 32)
                {
                    //默认系统生成的密码需要修改
                    return ResultHelper.Fail("请修改密码后再解绑");
                }
            }

            //解绑WeiXin
            return updateUserSetUnionId("", req.Filter.UserId);
        }

        private Response updateUserSetUnionId(string WeiXinUnionId, string UserId)
        {
            var sql = @"UPDATE dbo.UserAccount SET WeiXinUnionId=@WeiXinUnionId WHERE Id=@Id ";
            var cmd = CommandHelper.CreateText<ClubUser>(FetchType.Execute, sql);
            cmd.Params.Add("@WeiXinUnionId", WeiXinUnionId);
            cmd.Params.Add("@Id", UserId);

            var result = DbContext.GetInstance().Execute(cmd);
            return result;
        }

        private Response updateUserSetOpenId(string QQOpenId, string UserId)
        {
            var sql = @"UPDATE dbo.UserAccount SET QQOpenId=@QQOpenId WHERE Id=@Id ";
            var cmd = CommandHelper.CreateText<ClubUser>(FetchType.Execute, sql);
            cmd.Params.Add("@QQOpenId", QQOpenId);
            cmd.Params.Add("@Id", UserId);

            var result = DbContext.GetInstance().Execute(cmd);
            return result;
        }
    }

}
