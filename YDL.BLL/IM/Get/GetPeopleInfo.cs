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
    /// 拉取IM用户资料
    /// </summary>
    public class GetPeopleInfo : IServiceBase
    {
        /// <summary>
        /// 拉取资料
        /// </summary>
        /// <param name="currentUser"></param>
        /// <param name="request"></param>
        /// <returns></returns>
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<PeopleInfo>>(request);
            PeopleInfo people = new PeopleInfo();
            var reqRest = new RestRequest("v4/profile/portrait_get", Method.POST);
            people.To_Account.Add("160000000190");//只需修改此值即可调试
            people.TagList.Add("Tag_Profile_IM_Nick");

            reqRest.AddJsonBody(people);

            var rsp = RestApiHelper.SendIMRequest<IMMessageResult>(reqRest);
            PeopleInfo peo = new PeopleInfo();
            
            return new Response() { IsSuccess = rsp.Data.ErrorCode == 0, Message = rsp.Content };

        }
    }
}
