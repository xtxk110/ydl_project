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
    /// 获取课程表 教学点 课程列表
    /// </summary>
    public class GetSyllabusTeachingPointCourseList : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetCoachRelatedFilter>>(request);
            var sql = @"
 SELECT 	
    a.*,
	FillPosition=(SELECT COUNT(*) FROM dbo.CoachCourseJoin WHERE CourseId=a.Id)
 FROM dbo.CoachCourse a
 WHERE a.BeginTime>=@BeginTime AND a.EndTime<@EndTime
 AND a.VenueId=@VenueId AND Type=@CourseType
 ORDER BY a.BeginTime 
";
            var cmd = CommandHelper.CreateText<CoachCourse>(FetchType.Fetch, sql);
            var BeginTime = Convert.ToDateTime(req.Filter.SyllabusTime.ToShortDateString());
            var EndTime = BeginTime.AddDays(1).AddMinutes(-1);
            cmd.Params.Add("@BeginTime", BeginTime);
            cmd.Params.Add("@EndTime", EndTime);
            cmd.Params.Add("@VenueId", req.Filter.VenueId);
            cmd.Params.Add("@CourseType", CoachDic.BigCourse);


            var result = DbContext.GetInstance().Execute(cmd);
            foreach (var item in result.Entities)
            {
                var obj = item as CoachCourse;
                obj.CourseMaxPosition = CoachDic.BigCourseMaxPerson;//大课最多报名人数
                obj.CourseGradeName = CoachDic.GetCourseGradeName(obj.CourseGrade);
            }
            return result;

        }


    }
}
