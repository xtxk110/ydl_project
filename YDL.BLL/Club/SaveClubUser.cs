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
    /// 保存俱乐部成员，以及管理员直接拖人加入(界面叫邀请成员)
    /// </summary>
    public class SaveClubUser : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<ClubUser>>(request);
            var obj = req.Entities.FirstOrDefault();
            obj.ClubId = obj.ClubId.GetId();
            obj.UserId = obj.UserId.GetId();
            obj.SetNewEntity();
            //验证是否是俱乐部成员，存在则直接返回
            if (ClubHelper.HasClubMember(obj.ClubId, obj.UserId))
            {
                return ResultHelper.Fail("已经是俱乐部成员。");
            }
            var cmd = CommandHelper.CreateSave(req.Entities);
            var result = DbContext.GetInstance().Execute(cmd);
            if (result.IsSuccess)
            {
                ClubHelper.Instance.ImportToIMGroup(obj.ClubId, UserHelper.GetUserById(obj.UserId).Code);
            }
            return result;
        }

        ////同步导入这个人到腾讯IM群(给所有成员下发加群通知)
        //public Response AddToIMGroup(string clubId, string userCode)
        //{
        //    IMGroup obj = new IMGroup();
        //    obj.GroupId = clubId;
        //    var member= new IMGroupMember();
        //    member.Member_Account = userCode;
        //    obj.MemberList.Add(member);

        //    //请求导入
        //    var reqRest = new RestRequest("v4/group_open_http_svc/import_group_member", Method.POST);
        //    reqRest.AddJsonBody(obj);
        //    return RestApiHelper.SendIMRequestAndGetResponse(reqRest);
        //}


    }

}
