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
    /// 获取用户加入的群列表(用于调试)
    /// </summary>
    public class GetJoinedGroupList : IServiceBase
    {
        /// <summary>
        /// 拉取资料
        /// </summary>
        /// <param name="currentUser"></param>
        /// <param name="request"></param>
        /// <returns></returns>
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<IMGroup>>(request);
            var reqRest = new RestRequest("v4/group_open_http_svc/get_joined_group_list", Method.POST);
            reqRest.AddJsonBody(req.FirstEntity());

            var rsp = RestApiHelper.SendIMRequest<IMMessageResult>(reqRest);
            
            return new Response() { IsSuccess = rsp.Data.ErrorCode == 0, Message = rsp.Content };

        }
    }
}
