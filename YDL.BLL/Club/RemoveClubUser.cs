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
    /// 移除俱乐部某个或多个成员
    /// </summary>
    public class RemoveClubUser : IService
    {
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<ClubUser>>(request);
            if (req.Entities.Count == 0)
            {
                return ResultHelper.Fail("要移除的成员为空, 请传要移除的成员");
            }

            Response result = new Response();
            foreach (var obj in req.Entities)
            {
                var cmd = CommandHelper.CreateText(FetchType.Execute, "DELETE FROM ClubUser WHERE ClubId=@clubId AND UserId=@userId");
                cmd.CreateParamUser(obj.UserId.GetId());
                cmd.Params.Add("@clubId", obj.ClubId.GetId());

                result = DbContext.GetInstance().Execute(cmd);

                //退群通知管理员及本人
                try
                {
                    var club = ClubHelper.GetClub(obj.ClubId);
                    var admins = ClubHelper.GetClubAdminIdList(obj.ClubId);
                    admins.Add(obj.UserId.GetId());
                    JPushHelper.SendNotify(MasterType.CLUB.Id, obj.ClubId, string.Format("您已退出群[{0}]。", club.Name), admins);
                }
                catch (Exception)
                {
                }
            }

            //删除IM群成员
            if (result.IsSuccess)
            {
                result = RemoveGroupMember(req);
            }
            return result;
        }

        /// <summary>
        /// 删除IM群成员
        /// </summary>
        /// <returns></returns>
        public Response RemoveGroupMember(Request<ClubUser> req)
        {
            IMGroup obj = new IMGroup();
            obj.Silence = 1;
            obj.GroupId = req.Entities.First().ClubId;//列表里面的所有clubId 都是一样的
            foreach (var clubUser in req.Entities)
            {
                obj.MemberToDel_Account.Add(clubUser.UserCode);
            }
            //请求腾讯IM接口
            var reqRest = new RestRequest("v4/group_open_http_svc/delete_group_member", Method.POST);
            reqRest.AddJsonBody(obj);
            return RestApiHelper.SendIMRequestAndGetResponse(reqRest);
        }
    }

}
