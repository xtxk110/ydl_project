using Newtonsoft.Json;
using RestSharp;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Core;
using YDL.Map;
using YDL.Model;
using YDL.Utility;

namespace YDL.BLL
{
    public class IMHelper
    {
        public static IMHelper Instance = new IMHelper();
        public Response ImportAccount(User user)
        {
            var reqRest = new RestRequest("v4/im_open_login_svc/account_import", Method.POST);
            AccountImport account = new AccountImport();
            account.Identifier = user.Code;
            if (user.PetName.Length >= 10)
            {
                account.Nick = user.PetName.Substring(0, 9);
            }
            else
            {
                account.Nick = user.PetName;
            }
            if (!string.IsNullOrEmpty(user.HeadUrl))
            {
                account.FaceUrl = user.HeadUrl;
            }
            else
            {
                account.FaceUrl = "";
            }
            reqRest.AddJsonBody(account);
            return RestApiHelper.SendIMRequestAndGetResponse(reqRest);
        }

        /// <summary>
        /// 修改IM群
        /// </summary>
        /// <returns></returns>
        public Response UpdateIMGroup(Club club)
        {
            Response result = new Response();
            IMGroup obj = new IMGroup();
            obj.GroupId = club.Id;
            obj.FaceUrl = club.HeadUrl;
            obj.Name = club.Name;
            //请求导入
            var reqRest = new RestRequest("v4/group_open_http_svc/modify_group_base_info", Method.POST);
            reqRest.AddJsonBody(obj);
            return RestApiHelper.SendIMRequestAndGetResponse(reqRest);
        }

        /// <summary>
        /// 同步已有的俱乐部到IM群
        /// </summary>
        /// <param name="clubId"></param>
        /// <returns></returns>
        public Response ImportExistClubToIMGroup(string clubId)
        {
            //新建IM群 文档：https://www.qcloud.com/document/product/269/1615
            var sql = @"
  SELECT 
	TOP 1 
    b.Id AS GroupId,
	c.Code AS Owner_Account,
	b.Name ,
	b.Introduce AS Introduction,
	b.HeadUrl AS FaceUrl
 FROM dbo.ClubUser a
 INNER JOIN dbo.Club b ON a.ClubId=b.Id
 INNER JOIN dbo.UserAccount c ON a.UserId=c.Id
 WHERE ClubId=@ClubId AND a.IsCreator=1 AND a.IsAdmin =1

";
            var cmd = CommandHelper.CreateText<IMGroup>(FetchType.Fetch, sql);
            cmd.Params.Add("@ClubId", clubId);

            var result = DbContext.GetInstance().Execute(cmd);
            IMGroup obj = result.FirstEntity<IMGroup>();
            if (obj == null)
            {
                return ResultHelper.Success();
            }
            if (obj.Name.Length >= 6)
            {
                obj.Name = obj.Name.Substring(0, 5) + "...";
            }

            if (obj.Introduction.Length >= 71)
            {
                obj.Introduction = obj.Introduction.Substring(0, 70);
            }

            obj.Type = "Public";//Public 是公开群, 最大成员数2000 https://www.qcloud.com/document/product/269/1615
            obj.ApplyJoinOption = "FreeAccess";
            obj.MemberList = GetUserList(clubId);
            foreach (var item in obj.MemberList)
            {
                if (item.Member_Account == obj.Owner_Account)
                {
                    item.Role = null;
                }
            }
            //请求导入
            var reqRest = new RestRequest("v4/group_open_http_svc/create_group", Method.POST);
            reqRest.AddJsonBody(obj);
            return RestApiHelper.SendIMRequestAndGetResponse(reqRest);

        }

        public List<IMGroupMember> GetUserList(string ClubId)
        {
            var sql = @"
 SELECT 
    b.Code AS Member_Account,
	Role=(CASE WHEN a.IsAdmin=1 THEN 'Admin' ELSE null END)
FROM dbo.ClubUser a
INNER JOIN dbo.UserAccount b ON a.UserId=b.Id
WHERE ClubId=@ClubId


";
            var cmd = CommandHelper.CreateText<IMGroupMember>(FetchType.Fetch, sql);
            cmd.Params.Add("@ClubId", ClubId);

            var result = DbContext.GetInstance().Execute(cmd);
            return result.Entities.ToList<EntityBase, IMGroupMember>();

        }

        public Response SendIMSystemMsg(CustomInfo customeInfo, string userCode)
        {
            var reqRest = new RestRequest("v4/openim/sendmsg", Method.POST);
            MessageInfo messageInfo = new MessageInfo();
            messageInfo.SyncOtherMachine = 2;
            messageInfo.To_Account = userCode;
            messageInfo.MsgRandom = new Random().Next(999999);

            MessageBody messageBody = new MessageBody();
            messageBody.MsgType = "TIMCustomElem";

            MessageContent messageContent = new MessageContent();
            DataInfo dataInfo = new DataInfo();
            dataInfo.userAction = 10;
            dataInfo.customInfo = customeInfo;
            messageContent.Data = JsonConvert.SerializeObject(dataInfo);

            messageBody.MsgContent = messageContent;
            messageInfo.MsgBody.Add(messageBody);

            reqRest.AddJsonBody(messageInfo);
            return RestApiHelper.SendIMRequestAndGetResponse(reqRest);

        }

    }
}
