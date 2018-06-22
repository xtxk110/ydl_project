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
    /// 此接口用于, 用户详情界面绑定 qq 微信  done
    /// </summary>
    public class BindWeiXinQQ_184 : IService
    {

        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetUserRelatedFilter>>(request);
            //首先判断手机号是否绑定
            var user = UserHelper.GetUserById(req.Filter.UserId);
            if (string.IsNullOrEmpty(user.Mobile))
            {
                //提示用户先绑定手机(这是重要基础数据)
                return ResultHelper.Fail("请先绑定手机");
            }

            //如果有WeiXinTempCode 就获取 unionId
            if (!string.IsNullOrEmpty(req.Filter.WeiXinTempCode))
            {
                //获取WeiXinUnionId
                var weiXinUser = SystemHelper.Instance.getWeiXinUserInfo(req.Filter.WeiXinTempCode);
                if (weiXinUser.unionid == null)
                {
                    weiXinUser.unionid = "";
                }
                req.Filter.WeiXinUnionId = weiXinUser.unionid;
            }

            //检查此qq或微信是否和已有账户绑定
            var result = getUserByQQWeiXinId(req);

            if (result.Entities.Count == 0)
            {
                //不存在就绑定到传来的账户上
                if (!string.IsNullOrEmpty(req.Filter.QQOpenId)) //qq绑定
                {
                    result = updateUserSetOpenId(req);
                }
                else if (!string.IsNullOrEmpty(req.Filter.WeiXinUnionId))//微信绑定
                {
                    result = updateUserSetUnionId(req);
                }
            }
            else
            {
                //存在就提示用户去解除绑定
                return ResultHelper.Fail("已绑定其他账号,绑定失败");
            }

            return result;
        }

        private Response getUserByQQWeiXinId(Request<GetUserRelatedFilter> req)
        {
            string sql = "";
            if (!string.IsNullOrEmpty(req.Filter.QQOpenId))
            {
                sql = @"
SELECT * FROM dbo.UserAccount WHERE QQOpenId=@QQOpenId
";
            }
            else if (!string.IsNullOrEmpty(req.Filter.WeiXinUnionId))
            {
                sql = @"
SELECT * FROM dbo.UserAccount WHERE WeiXinUnionId=@WeiXinUnionId
";
            }
            Response result = new Response();
            if (!string.IsNullOrEmpty(sql))
            {
                var cmd = CommandHelper.CreateText<User>(FetchType.Fetch, sql);
                cmd.Params.Add("@WeiXinUnionId", req.Filter.WeiXinUnionId);
                cmd.Params.Add("@QQOpenId", req.Filter.QQOpenId);
                result = DbContext.GetInstance().Execute(cmd);
            }

            return result;
        }

        private Response updateUserSetUnionId(Request<GetUserRelatedFilter> req)
        {
            var sql = @"UPDATE dbo.UserAccount SET WeiXinUnionId=@WeiXinUnionId WHERE Id=@Id ";
            var cmd = CommandHelper.CreateText<User>(FetchType.Execute, sql);
            cmd.Params.Add("@WeiXinUnionId", req.Filter.WeiXinUnionId);
            cmd.Params.Add("@Id", req.Filter.UserId);

            var result = DbContext.GetInstance().Execute(cmd);
            return result;
        }

        private Response updateUserSetOpenId(Request<GetUserRelatedFilter> req)
        {
            var sql = @"UPDATE dbo.UserAccount SET QQOpenId=@QQOpenId WHERE Id=@Id ";
            var cmd = CommandHelper.CreateText<User>(FetchType.Execute, sql);
            cmd.Params.Add("@QQOpenId", req.Filter.QQOpenId);
            cmd.Params.Add("@Id", req.Filter.UserId);

            var result = DbContext.GetInstance().Execute(cmd);
            return result;
        }
    }

}
