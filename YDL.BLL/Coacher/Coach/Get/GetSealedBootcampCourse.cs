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
    /// 获取封闭机构的集训班课程信息
    /// </summary>
    public class GetSealedBootcampCourse_189 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetCoachRelatedFilter>>(request);
            var sql = @"
 SELECT 
    a.*,
    '027005' AS Type,
    '集训班' AS TypeName,
	b.Name AS CourseName,
	c.Address AS VenueAddress
 FROM dbo.CoachBootcampCourse a
 INNER JOIN dbo.CoachBootcamp b ON a.CoachBootcampId=b.Id
 LEFT JOIN dbo.Venue c ON b.VenueId=c.Id
 WHERE 
        a.Id=@BootcampCourseTemplateId
";
            var cmd = CommandHelper.CreateText<CoachCourse>(FetchType.Fetch, sql);
            cmd.Params.Add("@BootcampCourseTemplateId", req.Filter.BootcampCourseTemplateId);
            var result = DbContext.GetInstance().Execute(cmd);
            return result;
        }

    }
}
