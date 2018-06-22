
using Newtonsoft.Json;
using System.Collections.Generic;
using YDL.Core;
using YDL.Map;
using YDL.Model;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 获取用户联系人列表(done)
    /// </summary>
    public class GetUserContactList : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetUserListFilter>>(request);

            Response rsp = new Response();
            rsp.IsSuccess = true;
            rsp.Entities = new List<EntityBase>();
            UserContactList obj = new UserContactList();
            obj.MyCoach = GetMyCoachList(req.Filter.CurrentUserId);
            obj.MyStudent = GetMyStudentList(req.Filter.CurrentUserId);
            obj.FavoriteVenue = GetMyFavoriteVenueList(req.Filter.CurrentUserId);
            obj.IsCoach = CoachHelper.Instance.IsCoach(req.Filter.CurrentUserId);
            rsp.Entities.Add(obj);

            return rsp;
        }

        public List<Coach> GetMyCoachList(string studentUserId)
        {

            var sql = @"
SELECT 
	Id,
	HeadUrl,
	Sex,
	Name= dbo.fn_GetUserName(Id) 
FROM dbo.UserAccount 
WHERE Id IN  
(
     SELECT 
	    DISTINCT
	    CoachId
     FROM dbo.CoachStudentMoney 
     WHERE StudentUserId=@StudentUserId AND CourseTypeId='027003'
)
";
            var cmd = CommandHelper.CreateText<Coach>(FetchType.Fetch, sql);
            cmd.Params.Add("@StudentUserId", studentUserId);
            var result = DbContext.GetInstance().Execute(cmd);
            return result.Entities.ToList<EntityBase, Coach>();
        }

        public List<CoachStudent> GetMyStudentList(string coachId)
        {

            var sql = @"
SELECT 
	Id,
	HeadUrl,
	Sex,
	Name= dbo.fn_GetUserName(Id) 
FROM dbo.UserAccount 
WHERE Id IN  
(
     SELECT 
	    DISTINCT
	    StudentUserId
     FROM dbo.CoachStudentMoney 
     WHERE CoachId=@coachId AND CourseTypeId='027003'
)
";
            var cmd = CommandHelper.CreateText<CoachStudent>(FetchType.Fetch, sql);
            cmd.Params.Add("@coachId", coachId);
            var result = DbContext.GetInstance().Execute(cmd);
            return result.Entities.ToList<EntityBase, CoachStudent>();
        }

        public List<Venue> GetMyFavoriteVenueList(string currentUserId)
        {

            var sql = @"
 SELECT 
	 b.Id,
	 b.HeadUrl,
	 b.Name
 FROM dbo.CoachUserFavorite  a
 LEFT JOIN dbo.Venue b ON a.FavoriteId=b.Id
 WHERE UserId=@UserId AND a.FavoriteType='Venue'
";
            var cmd = CommandHelper.CreateText<Venue>(FetchType.Fetch, sql);
            cmd.Params.Add("@UserId", currentUserId);
            var result = DbContext.GetInstance().Execute(cmd);
            return result.Entities.ToList<EntityBase, Venue>();
        }

    }

}
