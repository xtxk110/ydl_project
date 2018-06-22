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
    /// 获取教练请假时有课列表
    /// </summary>
    public class GetCoachHaveCourseList_187 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetCoachRelatedFilter>>(request);
            var sql = @"
SELECT 	
    a.*,
	b.Name AS TypeName,
	c.Name AS VenueAddress
 FROM dbo.CoachCourse a 
 LEFT JOIN dbo.BaseData b ON a.Type=b.Id
 LEFT JOIN dbo.Venue c ON a.VenueId=c.Id
 WHERE 
    a.BeginTime>=@BeginTime AND a.EndTime<@EndTime
	AND a.CoachId=@CoachId
 ORDER BY a.BeginTime 
";
            var cmd = CommandHelper.CreateText<CoachCourse>(FetchType.Fetch, sql);
            cmd.Params.Add("@BeginTime",req.Filter.BeginTime);
            cmd.Params.Add("@EndTime", req.Filter.EndTime);
            cmd.Params.Add("@CoachId", req.Filter.CurrentUserId);

            var result = DbContext.GetInstance().Execute(cmd);
            return result;
        }
         
    }
}
