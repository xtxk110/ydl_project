using System;
using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Core;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 获取课程表我常去的教学点(学员用)
    /// </summary>
    public class GetSyllabusOftenTeachingPointList : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {


            var req = JsonConvert.DeserializeObject<Request<GetCoachRelatedFilter>>(request);
            var sql = @"
    SELECT 
            TOP 3
			c.Id,
			c.HeadUrl,
			c.Name,
			c.TableCount,
			c.CreateDate
	 FROM 
	 (
		 SELECT 
				rowNumber= ROW_NUMBER() OVER (PARTITION BY b.VenueId ORDER BY a.CreateDate DESC),
				c.Id,
				c.HeadUrl,
				c.Name,
				c.TableCount,
				a.CreateDate
		 FROM dbo.CoachCourseJoin a
		 INNER JOIN dbo.CoachCourse b ON a.CourseId=b.Id
		 INNER JOIN dbo.Venue c ON b.VenueId=c.Id
		 WHERE a.StudentId=@StudentId
	 ) c
	 WHERE c.rowNumber=1 /*获取分组内最新记录*/
	 ORDER BY c.CreateDate DESC
";
            var cmd = CommandHelper.CreateText<Venue>(FetchType.Fetch, sql);
            cmd.Params.Add("@StudentId", req.Filter.StudentId);
            var result = DbContext.GetInstance().Execute(cmd);
            return result;


        }





    }
}
