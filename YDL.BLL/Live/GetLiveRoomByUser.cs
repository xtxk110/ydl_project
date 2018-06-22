
using Newtonsoft.Json;
using System;
using System.Configuration;
using System.Security.Cryptography;
using System.Text;
using YDL.Core;
using YDL.Map;
using YDL.Model;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 获取房间详情
    /// </summary>
    public class GetLiveRoomByUser_193 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetLiveRelatedFilter>>(request);
            var sql = @"SELECT * FROM LiveRoom WHERE AnchorId=@userId;";
            var cmd = CommandHelper.CreateText<LiveRoom>(FetchType.Fetch, sql);
            cmd.Params.Add("@userId", currentUser.Id);
            var result = DbContext.GetInstance().Execute(cmd);
            var obj = result.FirstEntity<LiveRoom>();
            if (obj != null)
            {
                if (!string.IsNullOrEmpty(obj.VsGameLoopId))
                {
                    obj.VSDetail = LiveHelper.Instance.GetVSDetail(obj.VsOrderId, obj.VsGameLoopId);
                }
            }
            //推流地址
            result.Tag = LiveHelper.Instance.GetPushUrl(currentUser.Code, true);
            return result;
        }


    }

}
