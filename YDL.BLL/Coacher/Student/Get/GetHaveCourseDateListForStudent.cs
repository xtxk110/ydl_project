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
    /// 获取有课日期号数列表(学员界面用)
    /// </summary>
    public class GetHaveCourseDateListForStudent_186 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetCoachRelatedFilter>>(request);
            var sql = @"
-- 获取常规有课日期
SELECT 
	DISTINCT
	CONVERT(DATE,EndTime) AS CoachHaveCourseDate 
 FROM dbo.CoachCourse 
 WHERE ReservedPersonId=@StudentId 
	AND BeginTime>=@BeginTime  AND EndTime<=@EndTime
-- 获取集训课有课日期
UNION
SELECT 
	DISTINCT
	CONVERT(DATE,b.EndTime) AS CoachHaveCourseDate 
FROM dbo.CoachBootcampStudent a
INNER JOIN dbo.CoachBootcampCourse b ON a.CoachBootcampId=b.CoachBootcampId
WHERE
	a.StudentId=@StudentId
	AND b.BeginTime>=@BeginTime  AND b.EndTime<=@EndTime
";
            var cmd = CommandHelper.CreateText<CoachCourseExtend>(FetchType.Fetch, sql);
            cmd.Params.Add("@StudentId", req.Filter.CurrentUserId);
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
