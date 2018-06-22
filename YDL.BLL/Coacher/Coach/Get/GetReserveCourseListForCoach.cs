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
    /// 获取教练界面的约课列表
    /// </summary>
    public class GetReserveCourseListForCoach_186 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetCoachRelatedFilter>>(request);
            var sql = @"
SELECT 	
    a.*,
	b.Name AS TypeName,
	c.Name AS VenueAddress
 FROM dbo.CoachCourse a
 LEFT JOIN dbo.BaseData b ON a.Type=b.Id
 LEFT JOIN dbo.Venue c ON a.VenueId=c.Id
 WHERE 
    a.BeginTime>=@BeginTime AND a.EndTime<@EndTime
	AND a.CoachId=@CoachId
 ORDER BY a.BeginTime 
";
            var cmd = CommandHelper.CreateText<CoachCourse>(FetchType.Fetch, sql);
            var BeginTime = Convert.ToDateTime(req.Filter.SyllabusTime.ToShortDateString());
            var EndTime = BeginTime.AddDays(1).AddMinutes(-1);
            cmd.Params.Add("@BeginTime", BeginTime);
            cmd.Params.Add("@EndTime", EndTime);
            cmd.Params.Add("@CoachId", req.Filter.CurrentUserId);
            var result = DbContext.GetInstance().Execute(cmd);
            //将此教练集训下的课程模板列表添加到尾部
            var formalCourseList = result.Entities.ToList<EntityBase, CoachCourse>();
            var templateCourseList = GetCoachBootcampCourseTemplateList(BeginTime, EndTime, req.Filter.CurrentUserId);
            var filteredTemplateCourseList = CoachHelper.Instance.GetFilteredTemplateCourseList(formalCourseList, templateCourseList);
            result.Entities.AddRange(filteredTemplateCourseList);
            return result;

        }



        /// <summary>
        /// 获取教练集训下的课程模板列表
        /// </summary>
        /// <returns></returns>
        public List<CoachCourse> GetCoachBootcampCourseTemplateList(DateTime BeginTime, DateTime EndTime, string CoachId)
        {
            var sql = @"
 SELECT
    a.CoachBootcampId,
    a.BeginTime,
    a.EndTime,
    a.SealedOrganizationId,
	c.Name AS CoachName,
	d.Address AS VenueAddress,
    '027005' AS Type,
    '集训课' AS TypeName,
    a.Id AS BootcampCourseTemplateId,
    b.Id AS CoachId 
FROM dbo.CoachBootcampCourse a
INNER JOIN dbo.Coach b ON a.SealedOrganizationId=b.SealedOrganizationId
LEFT JOIN dbo.CoachBootcamp c ON a.CoachBootcampId=c.Id
LEFT JOIN dbo.Venue d ON c.VenueId=d.Id
WHERE
   b.Id=@CoachId
   AND a.BeginTime>=@BeginTime  AND a.EndTime<=@EndTime
ORDER BY a.BeginTime  
";
            var cmd = CommandHelper.CreateText<CoachCourse>(FetchType.Fetch, sql);
            cmd.Params.Add("@BeginTime", BeginTime);
            cmd.Params.Add("@EndTime", EndTime);
            cmd.Params.Add("@CoachId", CoachId);

            var result = DbContext.GetInstance().Execute(cmd);
            return result.Entities.ToList<EntityBase, CoachCourse>();
        }


    }
}
