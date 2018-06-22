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
    /// 获取集训班有课列表
    /// </summary>
    public class GetBootcampHaveCourseList_189 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetCoachRelatedFilter>>(request);
            var sql = @"
SELECT 
	DISTINCT
	CONVERT(DATE,EndTime) AS HaveCourseDate 
 FROM dbo.CoachBootcampCourse 
 WHERE CoachBootcampId=@CoachBootcampId
	AND BeginTime>=@BeginTime  AND EndTime<=@EndTime

";
            var cmd = CommandHelper.CreateText<CoachBootcampCourse>(FetchType.Fetch, sql);
            cmd.Params.Add("@CoachBootcampId", req.Filter.CoachBootcampId);
            var beginTime = req.Filter.BeginTime.ToShortDateString();
            cmd.Params.Add("@BeginTime", beginTime);
            var endTimeFirst = req.Filter.EndTime.ToShortDateString();
            var endTime = Convert.ToDateTime(endTimeFirst).AddDays(1).AddMinutes(-1);//得到这一天的最大值
            cmd.Params.Add("@EndTime", endTime);

            var result = DbContext.GetInstance().Execute(cmd);

            foreach (var item in result.Entities)
            {
                var obj = item as CoachBootcampCourse;
                obj.HaveCourseDate = Convert.ToDateTime(obj.HaveCourseDate.ToShortDateString());
            }

            return result;
        }
         
    }
}
