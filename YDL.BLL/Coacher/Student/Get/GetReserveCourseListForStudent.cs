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
    /// 获取学员界面的约课列表
    /// </summary>
    public class GetReserveCourseListForStudent_186 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetCoachRelatedFilter>>(request);
            var sql = @"
SELECT * FROM (
        -- 一般约课数据
        SELECT 	
            a.*,
	        b.Name AS TypeName,
	        c.Name AS VenueAddress
         FROM dbo.CoachCourse a
         LEFT JOIN dbo.BaseData b ON a.Type=b.Id
         LEFT JOIN dbo.Venue c ON a.VenueId=c.Id
         WHERE 
            a.BeginTime>=@BeginTime AND a.EndTime<@EndTime
	        AND a.ReservedPersonId=@ReservedPersonId
        -- 集训已排课数据
        UNION ALL
        SELECT 
	        a.*,
	        c.Name AS TypeName,
	        d.Name AS VenueAddress
        FROM dbo.CoachCourse a
        INNER JOIN dbo.CoachCoursePersonInfo b ON a.Id=b.CourseId
        LEFT JOIN dbo.BaseData c ON a.Type=c.Id
        LEFT JOIN dbo.Venue d ON a.VenueId=d.Id
        WHERE 
	        a.BeginTime>=@BeginTime AND a.EndTime<@EndTime
	        AND b.YdlUserId =@ReservedPersonId
) a
ORDER BY a.BeginTime 
";
            var cmd = CommandHelper.CreateText<CoachCourse>(FetchType.Fetch, sql);
            var BeginTime = Convert.ToDateTime(req.Filter.SyllabusTime.ToShortDateString());
            var EndTime = BeginTime.AddDays(1).AddMinutes(-1);
            cmd.Params.Add("@BeginTime", BeginTime);
            cmd.Params.Add("@EndTime", EndTime);
            cmd.Params.Add("@ReservedPersonId", req.Filter.CurrentUserId);
            var result = DbContext.GetInstance().Execute(cmd);
            foreach (var item in result.Entities)
            {
                var coachCourse = item as CoachCourse;
                coachCourse.ReservedPersonId = req.Filter.CurrentUserId;
                CoachHelper.Instance.CountCourseState(coachCourse);
                CoachHelper.Instance.SetCourseAvgScore(coachCourse);
            }

            //将此教练集训下的课程模板列表添加到尾部
            var formalCourseList = result.Entities.ToList<EntityBase, CoachCourse>();
            var templateCourseList = GetCoachBootcampCourseTemplateList(BeginTime, EndTime, req.Filter.CurrentUserId);
            var filteredTemplateCourseList = CoachHelper.Instance.GetFilteredTemplateCourseList(formalCourseList, templateCourseList);
            result.Entities.AddRange(filteredTemplateCourseList);
            return result;

        }

        /// <summary>
        /// 获取学员集训下的课程模板列表
        /// </summary>
        /// <returns></returns>
        public List<CoachCourse> GetCoachBootcampCourseTemplateList(DateTime BeginTime, DateTime EndTime, string StudentId)
        {
            var sql = @"
SELECT
    a.CoachBootcampId,
    a.BeginTime,
    a.EndTime,
	c.Name AS CoachName,
	d.Address AS VenueAddress,
    '027005' AS Type,
    '集训课' AS TypeName,
    a.Id AS BootcampCourseTemplateId
FROM dbo.CoachBootcampCourse a
INNER JOIN CoachBootcampStudent b ON a.CoachBootcampId=b.CoachBootcampId
LEFT JOIN dbo.CoachBootcamp c ON a.CoachBootcampId=c.Id
LEFT JOIN dbo.Venue d ON c.VenueId=d.Id
WHERE
   b.StudentId=@StudentId
   AND a.BeginTime>=@BeginTime  AND a.EndTime<=@EndTime
ORDER BY a.BeginTime 
  
";
            var cmd = CommandHelper.CreateText<CoachCourse>(FetchType.Fetch, sql);
            cmd.Params.Add("@BeginTime", BeginTime);
            cmd.Params.Add("@EndTime", EndTime);
            cmd.Params.Add("@StudentId", StudentId);

            var result = DbContext.GetInstance().Execute(cmd);
            return result.Entities.ToList<EntityBase, CoachCourse>();
        }




    }
}
