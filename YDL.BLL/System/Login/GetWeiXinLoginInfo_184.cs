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
    /// 微信登陆ydl app  (done)
    /// 业务逻辑: 
    ///     如果通过微信 UnionId 查询ydl账户, 存在就直接去登陆
    ///     如果不存在ydl账户, 就返回GoBindMobile 标识, 前端再调用 BindMobileForWinXinLogin_184 接口创建ydl账户
    /// </summary>
    public class GetWeiXinLoginInfo_184 : IService
    {

        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetUserRelatedFilter>>(request);
            //获取微信用户全局唯一unionId
            var obj = SystemHelper.Instance.getWeiXinUserInfo(req.Filter.WeiXinTempCode);
            if (string.IsNullOrEmpty(obj.unionid))
            {
                return ResultHelper.Fail("微信 unionid 为空");
            }
            //通过unionId查询数据库
            var result = getUserByWeiXinUnionId(obj.unionid);
            if (result.Entities.Count == 0)
            {
                //不存在unionId记录,  即后续要创建新的账号,准备如下基本信息,后续接口使用
                User user = new User();
                user.PetName = obj.nickname;
                user.Sex = obj.sex.ToString();
                user.WeiXinUnionId = obj.unionid;
                if (obj.headimgurl != "/0") // /0表示没有头像, 腾讯坑爹
                {
                    user.HeadUrl = SystemHelper.Instance.DownloadImageFromURL(obj.headimgurl);
                }

                user.ThirdPartyLoginState = "GoBindMobile";
                result.Entities.Add(user);

            }
            else // 存在unionId记录
            {
                var userFinal = result.FirstEntity<User>();
                if (!string.IsNullOrEmpty(userFinal.Mobile))
                {
                    userFinal.ThirdPartyLoginState = "GoLogin";
                }
                else
                {
                    userFinal.ThirdPartyLoginState = "GoBindMobile";
                }
            }

            var userObj = result.FirstEntity<User>() ?? new User();
            userObj.LoginType = SystemDic.WEIXIN_LOGIN;

            return result;
        }



        private Response getUserByWeiXinUnionId(string WeiXinUnionId)
        {
            string sql = @"
SELECT * FROM dbo.UserAccount WHERE WeiXinUnionId=@WeiXinUnionId
";
            var cmd = CommandHelper.CreateText<User>(FetchType.Fetch, sql);
            cmd.Params.Add("@WeiXinUnionId", WeiXinUnionId);
            var result = DbContext.GetInstance().Execute(cmd);
            return result;
        }
    }

}
