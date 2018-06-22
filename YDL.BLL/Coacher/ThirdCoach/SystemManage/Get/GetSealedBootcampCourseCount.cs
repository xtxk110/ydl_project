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
    /// 获取封闭机构的集训班课时统计
    /// </summary>
    public class GetSealedBootcampCourseCount_189 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetCoachRelatedFilter>>(request);
            var sql = @"
SELECT 
    COUNT(Id) AS CourseCreatedCount
FROM dbo.CoachBootcampCourse 
WHERE CoachBootcampId=@CoachBootcampId
";
            var cmd = CommandHelper.CreateText<CoachBootcamp>(FetchType.Fetch, sql);
            cmd.Params.Add("@CoachBootcampId", req.Filter.CoachBootcampId);
            var result = DbContext.GetInstance().Execute(cmd);
            var obj = result.FirstEntity<CoachBootcamp>();
            var bootcamp = CoachHelper.Instance.GetCoachBootcampById(req.Filter.CoachBootcampId);
            obj.CourseCount = bootcamp.CourseCount;
            return result;

        }


    }
}
