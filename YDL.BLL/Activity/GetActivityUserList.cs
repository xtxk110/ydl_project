using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Core;

namespace YDL.BLL
{
    /// <summary>
    /// 获取活动成员列表，带分页功能
    /// </summary>
    public class GetActivityUserList : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetActivityUserListFilter>>(request);
            return ActivityHelper.GetActivityUserList(req.Filter);
        }
    }

}
