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
    /// 获取课程表 教练 课程列表
    /// </summary>
    public class GetSyllabusCoachCourseList : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetCoachRelatedFilter>>(request);
            var sql = @"
  SELECT 	
    a.*,
	b.Address AS VenueAddress,
	FillPosition=(SELECT COUNT(*) FROM dbo.CoachCourseJoin WHERE CourseId=a.Id)
 FROM dbo.CoachCourse a 
 INNER JOIN dbo.Venue b ON a.VenueId=b.Id
 WHERE a.BeginTime>=@BeginTime AND a.EndTime<@EndTime
 AND a.CoachId=@CoachId AND a.Type=@Type
 ORDER BY a.BeginTime 
";
            var cmd = CommandHelper.CreateText<CoachCourse>(FetchType.Fetch, sql);
            var BeginTime = Convert.ToDateTime(req.Filter.SyllabusTime.ToShortDateString());
            var EndTime = BeginTime.AddDays(1).AddMinutes(-1);
            cmd.Params.Add("@BeginTime", BeginTime);
            cmd.Params.Add("@EndTime", EndTime);
            cmd.Params.Add("@CoachId", req.Filter.CoachId);
            cmd.Params.Add("@Type", CoachDic.PrivateCourse);


            var result = DbContext.GetInstance().Execute(cmd);
            foreach (var item in result.Entities)
            {
                var obj = item as CoachCourse;
                obj.CourseMaxPosition = 1;//私教最多1人
            }
            return result;

        }


    }
}
