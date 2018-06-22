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
    /// 获取集训的课程的时间列表
    /// </summary>
    public class GetCoachBootcampCourseTimeList : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetSystemManageRelatedFilter>>(request);
            var sql = @"
SELECT 
	DISTINCT  CONVERT(VARCHAR(50),CONVERT(date, BeginTime))  AS CourseTime
FROM dbo.CoachBootcampCourse 
WHERE CoachBootcampId=@CoachBootcampId
";
            var cmd = CommandHelper.CreateText<CoachBootcampCourse>(FetchType.Fetch, sql);
            cmd.Params.Add("@CoachBootcampId", req.Filter.CoachBootcampId);
            var result = DbContext.GetInstance().Execute(cmd);
            return result;

        }


    }

}
