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
    /// 获取有课日期列表(场馆的或者全部的)
    /// </summary>
    public class GetHaveCourseDateList_187 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetCoachRelatedFilter>>(request);
            var sql = @"
SELECT 
	DISTINCT
	CONVERT(DATE,EndTime) AS CoachHaveCourseDate 
 FROM dbo.CoachCourse 
 WHERE   BeginTime>=@BeginTime  AND EndTime<=@EndTime
";
            if (!string.IsNullOrEmpty(req.Filter.VenueId))
            {
                sql += " AND VenueId=@VenueId";
            }


            var cmd = CommandHelper.CreateText<CoachCourseExtend>(FetchType.Fetch, sql);
            cmd.Params.Add("@VenueId", req.Filter.VenueId);
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
