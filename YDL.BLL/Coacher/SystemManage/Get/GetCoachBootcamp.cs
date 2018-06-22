using System;
using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Core;
using YDL.Utility;
using System.Collections.Generic;

namespace YDL.BLL
{
    /// <summary>
    /// 获取集训详情
    /// </summary>
    public class GetCoachBootcamp : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetSystemManageRelatedFilter>>(request);
            var sql = @"
SELECT 
	a.* ,
	b.Address AS VenueAddress,
    b.Name AS VenueName
FROM dbo.CoachBootcamp a
LEFT JOIN dbo.Venue b ON a.VenueId=b.Id
WHERE a.Id=@Id

";
            var cmd = CommandHelper.CreateText<CoachBootcamp>(FetchType.Fetch, sql);
            cmd.Params.Add("@Id", req.Filter.CoachBootcampId);
            var result = DbContext.GetInstance().Execute(cmd);
            var obj = result.FirstEntity<CoachBootcamp>();
            if (obj == null)
                return result;
            //取学员列表
            obj.BootcampStudentList = GetBootcampStudentList(obj.Id);
            obj.BootcampStudentCount = GetBootcampStudentCount(obj.Id);
            //学员是否报名
            //if (CoachHelper.Instance.IsJoinedCoachBootcamp(obj.Id, req.Filter.CurrentUserId))
            //{
            //      obj.State = CoachDic.BootcampJoined;
            //}

            obj.IsVenueCourseManager = CoachHelper.Instance.IsCurrentVenueCourseManager(req.Filter.CurrentUserId, obj.VenueId);
            var managerObj = CoachHelper.Instance.GetVenueCourseManager(obj.VenueId);
            if (managerObj != null)
            {
                obj.VenueCourseManagerCode = managerObj.Code;
            }
            else
            {
                obj.VenueCourseManagerCode = "此场馆没有课程管理员";
            }
            return result;

        }



        public int GetBootcampStudentCount(string CoachBootcampId)
        {
            var sql = @"
SELECT
	COUNT(*) AS BootcampStudentCount
FROM dbo.CoachStudentMoney a
WHERE CoachBootcampId=@CoachBootcampId

";
            var cmd = CommandHelper.CreateText<CoachBootcamp>(FetchType.Fetch, sql);
            cmd.Params.Add("@CoachBootcampId", CoachBootcampId);
            var result = DbContext.GetInstance().Execute(cmd);
            var obj = result.FirstEntity<CoachBootcamp>();
            if (obj != null)
            {
                return obj.BootcampStudentCount;
            }
            else
            {
                return 0;
            }

        }


        public List<User> GetBootcampStudentList(string BootcampId)
        {
            var sql = @"
SELECT
	TOP 10 
	b.Id,
	b.Sex,
	b.HeadUrl,
	b.CardName
FROM dbo.CoachStudentMoney a
INNER JOIN dbo.UserAccount b ON a.StudentUserId=b.Id
WHERE CoachBootcampId=@CoachBootcampId
";
            var cmd = CommandHelper.CreateText<User>(FetchType.Fetch, sql);
            cmd.Params.Add("@CoachBootcampId", BootcampId);
            var result = DbContext.GetInstance().Execute(cmd);
            return result.Entities.ToList<EntityBase, User>();

        }


    }
}
