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
    /// 获取学员余额中 -- 大课的过期时间列表
    /// </summary>
    public class GetStudentBigCourseDeadlineList : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {


            var req = JsonConvert.DeserializeObject<Request<GetCoachRelatedFilter>>(request);
            var sql = @"
   SELECT 
        Amount,
	    Deadline 
   FROM dbo.CoachStudentMoney 
   WHERE StudentUserId=@StudentUserId AND CourseTypeId='027001' AND Amount!=0 
   ORDER BY Deadline ASC 
";
            var cmd = CommandHelper.CreateText<CoachStudentMoney>(FetchType.Fetch, sql);
            cmd.Params.Add("@StudentUserId", req.Filter.StudentId);
            var result = DbContext.GetInstance().Execute(cmd);
            return result;

        }


    }
}
