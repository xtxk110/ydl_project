using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Core;

namespace YDL.BLL
{
    /// <summary>
    /// 获取俱乐部管理员列表
    /// </summary>
    public class GetClubManagerList : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetClubRelatedFilter>>(request);
            var sql = @"
SELECT 
	b.*
FROM dbo.ClubUser a
INNER JOIN dbo.UserAccount b ON a.UserId=b.Id
WHERE  a.ClubId=@ClubId AND a.IsAdmin=1
";
            var cmd = CommandHelper.CreateText<User>(FetchType.Fetch, sql);
            cmd.Params.Add("@ClubId", req.Filter.ClubId);
            var result = DbContext.GetInstance().Execute(cmd);
            result.Tag = 15;//一个俱乐部管理员人数上限
            return result;
        }
    }    
}
