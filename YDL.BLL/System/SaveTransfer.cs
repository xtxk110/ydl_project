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
    /// 移交创建人
    /// </summary>
    public class SaveTransfer : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<Transfer>>(request);
            var obj = req.Entities.FirstOrDefault();
            obj.MasterType = obj.MasterType.GetId();
            obj.MasterId = obj.MasterId.GetId();

            List<EntityBase> entites = new List<EntityBase>();
            entites.Add(obj);
            if (obj.RowState == RowState.Added)
            {
                obj.TrySetNewEntity();
            }
            var cmd = CommandHelper.CreateSave(entites);
            cmd.AfterCommands = new List<Command> { AttachUpdateCreatorId(obj) };
            var rsp = DbContext.GetInstance().Execute(cmd);
            if (obj.MasterType == "016001")//活动
            {
                //如果是移交活动, 就将此移交人添加到活动成员中去(通过报名的方式添加)
                if (!ActivityHelper.ActivityUserIsExist(obj.MasterId, obj.TargetUserId))
                {
                    ActivitySignUp(obj);
                }
            }

            if (obj.MasterType == "016002" && rsp.IsSuccess)//移交俱乐部,同步IM 移交群给某人
            {
                ChangeGroupOwner(obj.MasterId, obj.TargetUserId);
            }
            return rsp;
        }

        /// <summary>
        /// 同步IM 移交群给某人
        /// </summary>
        /// <returns></returns>
        public Response ChangeGroupOwner(string clubId, string NewOwner_Account)
        {
            IMGroup obj = new IMGroup();
            obj.GroupId = clubId;
            obj.NewOwner_Account = NewOwner_Account;
            //请求IM接口
            var reqRest = new RestRequest("v4/group_open_http_svc/change_group_owner", Method.POST);
            reqRest.AddJsonBody(obj);
            return RestApiHelper.SendIMRequestAndGetResponse(reqRest);
        }

        private static Command AttachUpdateCreatorId(Transfer obj)
        {
            var cmd = CommandHelper.CreateProcedure(FetchType.Execute, "sp_UpdateTransferCreatorId");
            cmd.Params.Add("@masterType", obj.MasterType);
            cmd.Params.Add("@masterId", obj.MasterId);
            cmd.Params.Add("@targetUserId", obj.TargetUserId);
            cmd.Params.Add("@creatorId", obj.CreatorId);
            return cmd;
        }

        public static void ActivitySignUp(Transfer transfer)
        {
            ActivityUser activityUser = new ActivityUser();
            activityUser.ActivityId = transfer.MasterId;
            activityUser.IsJoined = false;
            activityUser.RowState = RowState.Added;
            activityUser.RowVersion = 0;
            activityUser.UserId = transfer.TargetUserId;
            ActivityHelper.ActivitySignUp(activityUser);
        }
    }

}
