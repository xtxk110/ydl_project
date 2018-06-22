using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Core;

namespace YDL.BLL
{
    /// <summary>
    /// 获取俱乐部成员列表，带分页功能
    /// </summary>
    public class GetClubUserList : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetClubUserListFilter>>(request);
            var result = ClubHelper.GetClubUserList(req.Filter);
            return result;
        }
    }
}
