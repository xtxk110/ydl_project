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
    /// 获取学员 我的课程余额
    /// </summary>
    public class GetStudentCourseBalance : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetCoachRelatedFilter>>(request);
            var sql = @"
SELECT
    '027005' AS CourseTypeId,
    '集训课' AS CourseTypeName,
	    Amount,
        ThenTotalAmount AS TotalAmount,
    '' AS CoachId,
    '' AS CoachName, 
    0 AS  CoachPrice,
    '' AS HeadUrl,
    '' AS CityId,
    '' AS CityName,
    'true' AS CoachIsEnabled,
    b.Name AS BootcampName,
    b.State AS  BootcampState,
    b.EndTime AS BootcampDeadline,
    a.CoachBootcampId AS BootcampId
FROM CoachStudentMoney a
INNER JOIN dbo.CoachBootcamp b ON a.CoachBootcampId=b.Id
WHERE a.StudentUserId=@StudentUserId AND a.CourseTypeId='027005'  
UNION ALL
SELECT
    '027001' AS CourseTypeId,
	'大课' AS CourseTypeName,
	SUM(Amount) AS Amount,
	SUM(ThenTotalAmount)AS TotalAmount,
	'' AS CoachId,
	'' AS CoachName, 
	CoachPrice=(SELECT BigCourse FROM dbo.CoachPrice WHERE CityCode=@cityId), /*获取大课的价格*/
    '' AS HeadUrl,
	@cityId AS CityId,
	CityName=(SELECT Name FROM dbo.City WHERE Id=@cityId),
    'true' AS CoachIsEnabled,
    '' AS BootcampName,
    '' AS  BootcampState,
    '' AS BootcampDeadline,
    '' AS BootcampId
 FROM CoachStudentMoney a
 WHERE a.StudentUserId=@StudentUserId AND a.CourseTypeId='027001'  
 UNION ALL
 SELECT 
    '027003' AS CourseTypeId,
   	'私教' AS CourseTypeName,
	SUM(a.Amount) AS Amount,
	SUM(a.ThenTotalAmount) AS TotalAmount,
	a.CoachId,
	b.CardName AS CoachName,
    CoachPrice=(
		    /*获取此等级教练的价格*/
			SELECT
				 CASE c.Grade 
				 WHEN 1  THEN CGrade
				 WHEN 2 THEN BGrade
				 WHEN 3 THEN AGrade
				 END 
			 FROM dbo.CoachPrice WHERE CityCode=f.CityId
	 ),
    b.HeadUrl,
	f.CityId,
	e.Name AS CityName,
    c.IsEnabled AS CoachIsEnabled,
    '' AS BootcampName,
    '' AS  BootcampState,
    '' AS BootcampDeadline,
    '' AS BootcampId
 FROM dbo.CoachStudentMoney a
 INNER JOIN dbo.UserAccount b ON a.CoachId=b.Id
 INNER JOIN dbo.Coach c ON a.CoachId=c.Id
 INNER JOIN  dbo.Venue f ON c.VenueId=f.Id
 LEFT JOIN dbo.City e ON a.CityId=e.Id
 WHERE a.StudentUserId=@StudentUserId
 GROUP BY a.CoachId,b.CardName,c.Grade,b.HeadUrl,f.CityId,e.Name,c.IsEnabled
 
";
            var cmd = CommandHelper.CreateText<CoachStudentMoney>(FetchType.Fetch, sql);
            cmd.Params.Add("@StudentUserId", req.Filter.StudentId);
            cmd.Params.Add("@cityId", req.Filter.CityId);

            var result = DbContext.GetInstance().Execute(cmd);
            List<EntityBase> list = new List<EntityBase>();
            //处理大课的最小截止日期和剩余次数
            DealBigCourseDeadline(list, result, req);
            result.Entities = list;
            return result;


        }

        //处理大课的最小截止日期和剩余次数
        public void DealBigCourseDeadline(List<EntityBase> list, Response result, Request<GetCoachRelatedFilter> req)
        {
            foreach (var item in result.Entities)
            {
                CoachStudentMoney obj = item as CoachStudentMoney;
                if (obj.CourseTypeId == CoachDic.BigCourse)
                {
                    var bigCourseMin = GetBigCourseMin(req.Filter.StudentId);
                    if (bigCourseMin != null)
                    {
                        obj.BigCourseMinDeadline = bigCourseMin.BigCourseMinDeadline;
                        obj.BigCourseMinDeadlineCount = bigCourseMin.BigCourseMinDeadlineCount;

                    }
                }

                if (obj.CourseTypeId == CoachDic.BigCourse && result.Entities.Count > 0
                    && obj.Amount == 0 && obj.TotalAmount == 0)
                {
                    continue;
                }

                list.Add(obj as EntityBase);
            }

        }

        public CoachStudentMoney GetBigCourseMin(string StudentUserId)
        {
            var sql = @"
 SELECT  
	  a.Deadline AS BigCourseMinDeadline,
	  a.Amount AS BigCourseMinDeadlineCount
 FROM CoachStudentMoney a
 WHERE a.StudentUserId=@StudentUserId AND a.CourseTypeId='027001' AND a.Amount != 0
	AND 	a.Deadline=(
		SELECT MIN(a.Deadline) FROM CoachStudentMoney a
		WHERE a.StudentUserId=@StudentUserId AND a.CourseTypeId='027001' AND a.Amount != 0
	 )
 
";
            var cmd = CommandHelper.CreateText<CoachStudentMoney>(FetchType.Fetch, sql);
            cmd.Params.Add("@StudentUserId", StudentUserId);
            var result = DbContext.GetInstance().Execute(cmd);
            return result.FirstEntity<CoachStudentMoney>();
        }


    }
}
