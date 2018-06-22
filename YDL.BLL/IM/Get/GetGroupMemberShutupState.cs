using System.Linq;
using System.Configuration;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using RestSharp;
using System;
using YDL.Utility;
using System.Threading.Tasks;
using System.Threading;

namespace YDL.BLL
{
    /// <summary>
    /// 获取群用户禁言状态
    /// </summary>
    public class GetGroupMemberShutupState : IServiceBase
    {

        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetIMRelatedFilter>>(request);
            var reqRest = new RestRequest("v4/group_open_http_svc/get_group_shutted_uin", Method.POST);
            reqRest.AddJsonBody(new { GroupId = req.Filter.ClubId });

            var rsp = RestApiHelper.SendIMRequestAndGetResult(reqRest);
            var data = rsp.ShuttedUinList.Where(e => e.Member_Account == req.Filter.UserCode).First();
            Response result = new Response();
            result.IsSuccess = true;
            if (data != null)
            {
                result.Tag = true;
            }
            else
            {
                result.Tag = false;
            }
            return result;

        }
    }
}
