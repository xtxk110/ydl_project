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
    class ClubHelper
    {
        public static ClubHelper Instance = new ClubHelper();
        public static bool IsUserClubAdmin(string clubId, string userId)
        {
            var cmdClubUser = CommandHelper.CreateText<ClubUser>(FetchType.Fetch, "SELECT IsAdmin,IsCreator FROM dbo.ClubUser WHERE ClubId=@ClubId AND UserId=@UserId");
            cmdClubUser.Params.Add("@ClubId", clubId);
            cmdClubUser.Params.Add("@UserId", userId);
            var resultUser = DbContext.GetInstance().Execute(cmdClubUser);
            var clubUser = resultUser.Entities.FirstOrDefault() as ClubUser;
            if (clubUser == null || !clubUser.IsAdmin)
            {
                return false;
            }
            return true;
        }

            public static bool HasClubMember(string clubId, string userId)
            {
                var cmdVal = CommandHelper.CreateText<ClubUser>(FetchType.Scalar,text: "SELECT COUNT(*) FROM ClubUser WHERE ClubId=@clubId AND UserId=@userId");
                cmdVal.CreateParamUser(userId);
                cmdVal.Params.Add("@clubId", clubId);
                var result = DbContext.GetInstance().Execute(cmdVal);

                return (int)result.Tag > 0;
            }

        public static List<ClubAddress> GetClubAddressList(string clubId)
        {
            var cmdVal = CommandHelper.CreateProcedure<ClubAddress>(text: "sp_GetClubAddressList");
            cmdVal.Params.Add("@clubId", clubId);
            var result = DbContext.GetInstance().Execute(cmdVal);

            return result.Entities.ToList<EntityBase, ClubAddress>();
        }

        public static List<string> GetClubUserIdList(string clubId)
        {
            var cmdVal = CommandHelper.CreateText<ClubUser>(text: "SELECT UserId FROM ClubUser WHERE ClubId=@clubId");
            cmdVal.Params.Add("@clubId", clubId);
            var result = DbContext.GetInstance().Execute(cmdVal);

            return result.Entities.ToList<EntityBase, ClubUser>().Select(p => p.UserId).ToList();
        }

        public static List<string> GetClubAdminIdList(string clubId)
        {
            var cmdVal = CommandHelper.CreateText<ClubUser>(text: "SELECT UserId FROM ClubUser WHERE ClubId=@clubId AND IsAdmin=1 ");
            cmdVal.Params.Add("@clubId", clubId);
            var result = DbContext.GetInstance().Execute(cmdVal);

            return result.Entities.ToList<EntityBase, ClubUser>().Select(p => p.UserId).ToList();
        }

        public static Club GetClub(string clubId)
        {
            var cmdVal = CommandHelper.CreateText<Club>(text: "SELECT * FROM Club WHERE Id=@clubId ");
            cmdVal.Params.Add("@clubId", clubId);
            var result = DbContext.GetInstance().Execute(cmdVal);

            return result.FirstEntity<Club>();
        }

        /// <summary>
        /// 获取俱乐部成员公共方法
        /// </summary>
        /// <param name="filter"></param>
        /// <returns></returns>
        public static Response GetClubUserList(GetClubUserListFilter filter)
        {
            var cmd = CommandHelper.CreateProcedure<ClubUser>(text: "sp_GetClubUserList");
            cmd.Params.Add(CommandHelper.CreateParam("@clubId", filter.ClubId));
            cmd.Params.Add(CommandHelper.CreateParam("@petName", filter.PetName));
            cmd.Params.Add(CommandHelper.CreateParam("@isAdmin", filter.IsAdmin, DataType.Boolean));
            cmd.CreateParamPager(filter);

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();

            return result;
        }

        /// <summary>
        /// 同步导入这个人到腾讯IM群(无消息)
        /// </summary>
        /// <param name="clubId"></param>
        /// <param name="userCode"></param>
        /// <returns></returns>
        public Response ImportToIMGroup(string clubId, string userCode)
        {
            IMGroup obj = new IMGroup();
            obj.GroupId = clubId;
            IMGroupMember groupMember = new IMGroupMember();
            groupMember.Member_Account = userCode;
            obj.MemberList.Add(groupMember);

            //请求IM接口
            var reqRest = new RestRequest("v4/group_open_http_svc/import_group_member", Method.POST);
            reqRest.AddJsonBody(obj);

            var result = RestApiHelper.SendIMRequestAndGetResponse(reqRest);
            return result;
        }
    }
}
