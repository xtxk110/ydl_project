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
    /// 获取群全员禁言状态
    /// </summary>
    public class GetGroupShutupState : IServiceBase
    {

        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetIMRelatedFilter>>(request);
            var reqRest = new RestRequest("v4/group_open_http_svc/get_group_shutted_uin", Method.POST);
            reqRest.AddJsonBody(new { GroupId = req.Filter.ClubId });

            var rsp = RestApiHelper.SendIMRequestAndGetResult(reqRest);
            int shutUpCount = rsp.ShuttedUinList.Count;
            int clubUserCount = GetClubGeneralUserCount(req.Filter.ClubId);
            Response result = new Response();
            result.IsSuccess = true;
            if (shutUpCount == clubUserCount && shutUpCount != 0)
            {
                result.Tag = true;
            }
            else
            {
                result.Tag = false;
            }
            return result;

        }

        /// <summary>
        /// 获取普通用户总数(管理员创建者除外) 
        /// </summary>
        /// <param name="clubId"></param>
        /// <returns></returns>
        public int GetClubGeneralUserCount(string clubId)
        {
            var sql = @"
 SELECT 
	b.Code AS UserCode
 FROM dbo.ClubUser a
 INNER JOIN dbo.UserAccount b ON a.UserId=b.Id
 WHERE 
	a.ClubId=@ClubId 
	AND a.IsAdmin=0 AND a.IsCreator=0
";
            var cmd = CommandHelper.CreateText<ClubUser>(FetchType.Fetch, sql);
            cmd.Params.Add("@ClubId", clubId);
            var result = DbContext.GetInstance().Execute(cmd);
            return result.Entities.Count;

        }
    }
}
