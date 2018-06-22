using System;
using System.Linq;
using System.Collections.Generic;

using Newtonsoft.Json;
using YDL.Core;
using YDL.Map;
using YDL.Model;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 审核入群用户
    /// </summary>
    public class AuditClubRequest : IServiceBase
    {
        /// <summary>
        /// 审核入群用户
        /// </summary>
        /// <param name="currentUser"></param>
        /// <param name="request"></param>
        /// <returns></returns>
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<ClubRequest>>(request);
            var obj = req.Entities.FirstOrDefault();

            var cmd = CommandHelper.CreateProcedure(FetchType.Execute, "sp_AuditClubRequest");
            cmd.Params.Add("@requestId", obj.Id);
            cmd.Params.Add("@level", obj.Level, DataType.Int32);
            cmd.Params.Add("@state", obj.State.GetId());
            cmd.Params.Add("@auditorId", obj.AuditorId.GetId());
            cmd.CreateParamMsg();

            var result = DbContext.GetInstance().Execute(cmd);

            //审核结果通知本人
            if (result.IsSuccess)
            {
                try
                {
                    var club = ClubHelper.GetClub(obj.ClubId);
                    var admins = new List<string> { obj.CreatorId.GetId() };
                    var msg = string.Format("您的入群请求[{0}]{1}。", club.Name, obj.State.GetId() == ClubRequestState.PASS.Id ? "已通过" : "被拒绝");
                    JPushHelper.SendNotify(MasterType.CLUB.Id, obj.ClubId, msg, admins);
                }
                catch (Exception)
                {
                }

                //同步加入IM群
                ClubHelper.Instance.ImportToIMGroup(obj.ClubId, UserHelper.GetUserById(obj.CreatorId.GetId()).Code);

            }

            return result;
        }

    }

}
