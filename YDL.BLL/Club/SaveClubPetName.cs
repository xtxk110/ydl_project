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
    /// 修改俱乐部成员昵称
    /// </summary>
    public class SaveClubPetName : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<ClubUser>>(request);
            var obj = req.FirstEntity();
            var sql = @"
UPDATE ClubUser 
    SET PetName=@petName 
WHERE ClubId=@ClubId AND UserId=@UserId
";
            var cmd = CommandHelper.CreateText(FetchType.Execute, sql);
            cmd.Params.Add("@ClubId", obj.ClubId);
            cmd.Params.Add("@UserId", obj.UserId);
            cmd.Params.Add("@petName", obj.PetName);

            var rsp = DbContext.GetInstance().Execute(cmd);
            if (rsp.IsSuccess)
            {
                //同步设置IM群成员昵称
                rsp = SetIMGroupAdmin(obj);
            }
            return rsp;
        }

        //同步设置IM群成员昵称
        //文档: https://www.qcloud.com/document/product/269/1623
        public Response SetIMGroupAdmin(ClubUser obj)
        {

            IMGroup imGroup = new IMGroup();
            imGroup.GroupId = obj.ClubId;
            imGroup.Member_Account = obj.UserCode;
            imGroup.NameCard = obj.PetName;
            //请求IM接口
            var reqRest = new RestRequest("v4/group_open_http_svc/modify_group_member_info", Method.POST);
            reqRest.AddJsonBody(imGroup);

            var result = RestApiHelper.SendIMRequestAndGetResponse(reqRest);
            return result;
        }
    }

}
