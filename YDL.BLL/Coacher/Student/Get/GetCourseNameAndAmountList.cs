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
    /// 获取课程名称和余额列表 (发布约课界面用)
    /// </summary>
    public class GetCourseNameAndAmountList_186 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetCoachRelatedFilter>>(request);
            
            var sql = @"
--私教
SELECT 
	a.CoachId AS CourseNameId,
	dbo.fn_GetUserName(b.Id) AS CourseName,
	a.CourseTypeName,
	a.CourseTypeId,
	SUM(a.Amount) AS Amount,
	CoachCode=b.Code,
	BigCourseUnitPrice=c.Price,
    d.Grade AS CoachGrade
FROM dbo.CoachStudentMoney a
LEFT JOIN dbo.UserAccount b ON a.CoachId=b.Id
LEFT JOIN dbo.CoachBigCourseInfo c ON a.BigCourseInfoId=c.Id
LEFT JOIN dbo.Coach d ON a.CoachId=d.Id
WHERE StudentUserId=@StudentId
	AND a.CoachId!='' 
GROUP BY a.CoachId ,b.Id,a.CourseTypeName,a.CourseTypeId,b.Code,c.Price,d.Grade
 UNION 
 --大课
 SELECT 
	a.BigCourseInfoId AS  CourseNameId,
	c.Name AS  CourseName,
	a.CourseTypeName,
	a.CourseTypeId,
	SUM(a.Amount) AS  Amount,
	CoachCode=b.Code,
	BigCourseUnitPrice=c.Price,
    d.Grade AS CoachGrade
 FROM dbo.CoachStudentMoney a
 LEFT JOIN dbo.UserAccount b ON a.CoachId=b.Id
 LEFT JOIN dbo.CoachBigCourseInfo c ON a.BigCourseInfoId=c.Id
 LEFT JOIN dbo.Coach d ON a.CoachId=d.Id
 WHERE StudentUserId=@StudentId
	AND a.BigCourseInfoId!='' AND Deadline > GETDATE() 
GROUP BY a.BigCourseInfoId ,c.Name,a.CourseTypeName,a.CourseTypeId,b.Code,c.Price,d.Grade


";
            var cmd = CommandHelper.CreateText<CoachStudentMoney>(FetchType.Fetch, sql);
            cmd.Params.Add("@StudentId", req.Filter.StudentId);

            var result = DbContext.GetInstance().Execute(cmd);
            foreach (var item in result.Entities)
            {
                CoachStudentMoney obj = item as CoachStudentMoney;
                if (obj.CourseTypeId==CoachDic.PrivateCourse)
                {
                    obj.CoachUnitPrice = CoachHelper.Instance.GetCoachUnitPrice("75",obj.CoachGrade);
                }
            }

            return result;


        }

       
    }
}
