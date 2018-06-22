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
    /// 获取约课列表(场馆的或者全部的)
    /// </summary>
    public class GetReserveCourseList_187 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetCoachRelatedFilter>>(request);
            var sql = @"
SELECT 	
    a.*,
	b.Name AS TypeName,
	c.Name AS VenueAddress,
	d.Score 
 FROM dbo.CoachCourse a
 LEFT JOIN dbo.BaseData b ON a.Type=b.Id
 LEFT JOIN dbo.Venue c ON a.VenueId=c.Id
 LEFT JOIN dbo.CoachComment d ON a.Id=d.CourseId
 WHERE 
    a.BeginTime>=@BeginTime AND a.EndTime<@EndTime
";
            if (!string.IsNullOrEmpty(req.Filter.VenueId))
            {
                sql += " AND VenueId=@VenueId ";
            }

            sql += @"
 ORDER BY a.BeginTime 
";
            var cmd = CommandHelper.CreateText<CoachCourse>(FetchType.Fetch, sql);
            var BeginTime = Convert.ToDateTime(req.Filter.SyllabusTime.ToShortDateString());
            var EndTime = BeginTime.AddDays(1).AddMinutes(-1);
            cmd.Params.Add("@BeginTime", BeginTime);
            cmd.Params.Add("@EndTime", EndTime);
            cmd.Params.Add("@VenueId", req.Filter.VenueId);

            var result = DbContext.GetInstance().Execute(cmd);
            return result;

        }


    }
}
