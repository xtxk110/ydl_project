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
    /// 保存俱乐部加入申请
    /// </summary>
    public class SaveClubRequest : IServiceBase
    {
        /// <summary>
        /// 保存俱乐部加入申请
        /// </summary>
        /// <param name="currentUser"></param>
        /// <param name="request"></param>
        /// <returns></returns>
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<ClubRequest>>(request);
            var obj = req.Entities.FirstOrDefault();

            var cmd = CommandHelper.CreateProcedure(FetchType.Execute, "sp_SaveClubRequest");
            cmd.Params.Add("@clubId", obj.ClubId.GetId());
            cmd.Params.Add("@userId", obj.CreatorId.GetId());
            cmd.Params.Add("@remark", obj.Remark);
            cmd.CreateParamMsg();

            var result = DbContext.GetInstance().Execute(cmd);
            //加群请求通知管理员
            if (result.IsSuccess)
            {
                try
                {
                    JPushHelper.SendNotify(MasterType.CLUB.Id, obj.ClubId, string.Format("有新入群请求，来自[{0}]。", currentUser.PetName), ClubHelper.GetClubAdminIdList(obj.ClubId));
                }
                catch (Exception)
                {
                }
            }
            return result;
        }

    }

}
