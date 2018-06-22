using System;
using System.Linq;
using System.Collections.Generic;

using Newtonsoft.Json;
using YDL.Core;
using YDL.Map;
using YDL.Model;
using YDL.Utility;
using RestSharp;

namespace YDL.BLL
{
    /// <summary>
    /// 设置或者取消管理员
    /// </summary>
    public class SaveClubAdmin : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<ClubUser>>(request);
            Response rsp = new Response();

            foreach (var obj in req.Entities)
            {
                var sql = @"
UPDATE ClubUser 
    SET IsAdmin=@IsAdmin 
WHERE ClubId=@ClubId AND UserId=@UserId
";
                var cmd = CommandHelper.CreateText(FetchType.Execute, sql);
                cmd.Params.Add("@ClubId", obj.ClubId);
                cmd.Params.Add("@UserId", obj.UserId);
                cmd.Params.Add("@IsAdmin", obj.IsAdmin);
                rsp = DbContext.GetInstance().Execute(cmd);

                if (rsp.IsSuccess)
                {
                    //极光推送
                    try
                    {
                        var msg = obj.IsAdmin ? "您被设置为管理员。" : "您被取消管理员权限";
                        JPushHelper.SendNotify(MasterType.CLUB.Id, obj.ClubId, msg, new List<string> { obj.UserId });
                    }
                    catch (Exception)
                    {
                    }
                    //同步设置IM群管理员
                    rsp = SetIMGroupAdmin(obj);
                    if (rsp.IsSuccess == false)
                    {
                        break;
                    }
                }

            }

            return rsp;
        }

        //同步设置IM群管理员
        //文档: https://www.qcloud.com/document/product/269/1623
        public Response SetIMGroupAdmin(ClubUser obj)
        {
            string role;
            if (obj.IsAdmin)
            {
                role = "Admin";
            }
            else
            {
                role = "Member";
            }
            IMGroup imGroup = new IMGroup();
            imGroup.GroupId = obj.ClubId;
            imGroup.Member_Account = obj.UserCode;
            imGroup.Role = role;
            //请求IM接口
            var reqRest = new RestRequest("v4/group_open_http_svc/modify_group_member_info", Method.POST);
            reqRest.AddJsonBody(imGroup);

            var result = RestApiHelper.SendIMRequestAndGetResponse(reqRest);
            return result;
        }

    }

}
