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
    /// 获取封闭机构的集训班课程列表(按天查询)
    /// </summary>
    public class GetSealedBootcampCourseList_189 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetCoachRelatedFilter>>(request);
            var sql = @"
 SELECT 
    a.*,
	b.Name AS BootcampName,
	c.Name AS VenueAddress
 FROM dbo.CoachBootcampCourse a
 INNER JOIN dbo.CoachBootcamp b ON a.CoachBootcampId=b.Id
 LEFT JOIN dbo.Venue c ON b.VenueId=c.Id
 WHERE 
    a.BeginTime>=@BeginTime AND a.EndTime<@EndTime
	AND a.CoachBootcampId=@CoachBootcampId
 ORDER BY a.BeginTime 


";
            var cmd = CommandHelper.CreateText<CoachBootcampCourse>(FetchType.Fetch, sql);
            var BeginTime = Convert.ToDateTime(req.Filter.SyllabusTime.ToShortDateString());
            var EndTime = BeginTime.AddDays(1).AddMinutes(-1);
            cmd.Params.Add("@BeginTime", BeginTime);
            cmd.Params.Add("@EndTime", EndTime);
            cmd.Params.Add("@CoachBootcampId", req.Filter.CoachBootcampId);


            var result = DbContext.GetInstance().Execute(cmd);
            return result;

        }


    }
}
