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
    /// 获取有课日期号数列表(教练界面用)
    /// </summary>
    public class GetHaveCourseDateListForCoach_186 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetCoachRelatedFilter>>(request);
            var sql = @"
-- 获取常规课程有课日期
SELECT 
	DISTINCT
	CONVERT(DATE,EndTime) AS CoachHaveCourseDate 
 FROM dbo.CoachCourse 
 WHERE CoachId=@CoachId
	AND BeginTime>=@BeginTime  AND EndTime<=@EndTime
UNION
-- 获取集训课程有课日期
 SELECT
	DISTINCT
	CONVERT(DATE,a.EndTime) AS CoachHaveCourseDate 
FROM dbo.CoachBootcampCourse a
INNER JOIN dbo.Coach b ON a.SealedOrganizationId=b.SealedOrganizationId
WHERE
   b.Id=@CoachId
   AND a.BeginTime>=@BeginTime  AND a.EndTime<=@EndTime


";
            var cmd = CommandHelper.CreateText<CoachCourseExtend>(FetchType.Fetch, sql);
            cmd.Params.Add("@CoachId", req.Filter.CurrentUserId);
            var beginTime = req.Filter.BeginTime.ToShortDateString();
            cmd.Params.Add("@BeginTime", beginTime);
            var endTimeFirst = req.Filter.EndTime.ToShortDateString();
            var endTime = Convert.ToDateTime(endTimeFirst).AddDays(1).AddMinutes(-1);//得到这一天的最大值
            cmd.Params.Add("@EndTime", endTime);
            var result = DbContext.GetInstance().Execute(cmd);

            foreach (var item in result.Entities)
            {
                var coachCourse = item as CoachCourseExtend;
                coachCourse.CoachHaveCourseDate = Convert.ToDateTime(coachCourse.CoachHaveCourseDate.ToShortDateString());
            }

            return result;
        }

      

    }
}
