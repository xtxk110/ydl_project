﻿using System;
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
    /// 获取学员 课程进度表详情
    /// </summary>
    public class GetStudentCourseScheduleDetail_186 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetCoachRelatedFilter>>(request);
            //赋默认值
            req.Filter.CityId = "75";
            //开始查询
            string studentId = req.Filter.StudentId;
            string cityId = req.Filter.CityId;
            string BigCourseInfoId = req.Filter.BigCourseInfoId;
            string CoachId = req.Filter.CoachId;
            List<EntityBase> list = new List<EntityBase>();
            Response result = new Response();
            if (req.Filter.CourseTypeId == CoachDic.BigCourse)
            {
                //获取大课余额
                result = GetBigCourseBalances(studentId, cityId, BigCourseInfoId);
                if (result.IsSuccess == false)
                {
                    return result;
                }
                //处理大课的最小截止日期和剩余次数
                DealBigCourseDeadline(result, req);
                var obj = result.FirstEntity<CoachStudentMoney>();
               
                list.Add(obj);
            }
            else if (req.Filter.CourseTypeId == CoachDic.PrivateCourse)
            {
                //获取私教余额
                result = GetPrivateCourseBalances(studentId, cityId, CoachId);
                if (result.IsSuccess == false)
                {
                    return result;
                }
                var obj = result.FirstEntity<CoachStudentMoney>();
            
                list.Add(obj);
            }

            else if (req.Filter.CourseTypeId == CoachDic.BootcampCourse)
            {
                //获取集训课余额
                result = GetBootcampBalances(req.Filter.CoachStudentMoneyId);
                SystemHelper.CheckResponseIfError(result);
                //处理集训课的截止日期和剩余次数
                DealBigCourseDeadline(result, req);
                var obj = result.FirstEntity<CoachStudentMoney>();
                list.Add(obj);
            }

            //最后返回
            result.Entities = list;
            return result;


        }

       
    
        public Response GetBootcampBalances(string coachStudentMoneyId)
        {
            //开始查询
            var sql = @"
 
SELECT
    '027005' AS CourseTypeId,
	'集训课' AS CourseTypeName,
	Amount,
	ThenTotalAmount,
	'75' AS CityId,
	CityName=(SELECT Name FROM dbo.City WHERE Id='75'),
	 b.Name AS BootcampName,
	 a.Deadline 
 FROM CoachStudentMoney a
 LEFT JOIN dbo.CoachBootcamp b ON a.CoachBootcampId =b.Id
WHERE 
	a.Id=@Id
";
            var cmd = CommandHelper.CreateText<CoachStudentMoney>(FetchType.Fetch, sql);
            cmd.Params.Add("@Id", coachStudentMoneyId);
            var result = DbContext.GetInstance().Execute(cmd);
            return result;
        }


        public Response GetBigCourseBalances(string StudentId, string cityId, string BigCourseInfoId)
        {
            //开始查询
            var sql = @"
 
SELECT
    '027001' AS CourseTypeId,
	'大课' AS CourseTypeName,
	SUM(Amount) AS Amount,
	SUM(ThenTotalAmount)AS ThenTotalAmount,
	'75' AS CityId,
	CityName=(SELECT Name FROM dbo.City WHERE Id='75'),
	a.BigCourseInfoId,
	b.Price AS BigCourseUnitPrice,
	b.Name AS BigCourseName
 FROM CoachStudentMoney a
 LEFT JOIN dbo.CoachBigCourseInfo b ON a.BigCourseInfoId =b.Id
 WHERE a.StudentUserId=@StudentUserId AND a.CourseTypeId='027001'  
    AND a.BigCourseInfoId=@BigCourseInfoId
 GROUP BY a.BigCourseInfoId,b.Price,b.Name/*根据大课类别出其余额汇总值*/
";
            var cmd = CommandHelper.CreateText<CoachStudentMoney>(FetchType.Fetch, sql);
            cmd.Params.Add("@StudentUserId", StudentId);
            cmd.Params.Add("@BigCourseInfoId", BigCourseInfoId);
            cmd.Params.Add("@cityId", cityId);

            var result = DbContext.GetInstance().Execute(cmd);
            return result;
        }


        public Response GetPrivateCourseBalances(string StudentId, string cityId, string coachId)
        {
            //开始查询
            var sql = @"
 
SELECT 
    '027003' AS CourseTypeId,
   	'私教' AS CourseTypeName,
	SUM(a.Amount) AS Amount,
	SUM(a.ThenTotalAmount) AS ThenTotalAmount,
	a.CoachId,
	b.CardName AS CoachName,
    CoachUnitPrice=(
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
    c.IsEnabled AS CoachIsEnabled 
  
 FROM dbo.CoachStudentMoney a
 INNER JOIN dbo.UserAccount b ON a.CoachId=b.Id
 INNER JOIN dbo.Coach c ON a.CoachId=c.Id
 INNER JOIN  dbo.Venue f ON c.VenueId=f.Id
 LEFT JOIN dbo.City e ON a.CityId=e.Id
 WHERE a.StudentUserId=@StudentUserId 
    AND a.CoachId=@CoachId
    AND a.CourseTypeId='027003' 
 GROUP BY a.CoachId,b.CardName,c.Grade,b.HeadUrl,f.CityId,e.Name,c.IsEnabled
 
";
            var cmd = CommandHelper.CreateText<CoachStudentMoney>(FetchType.Fetch, sql);
            cmd.Params.Add("@StudentUserId", StudentId);
            cmd.Params.Add("@cityId", cityId);
            cmd.Params.Add("@CoachId", coachId);
            var result = DbContext.GetInstance().Execute(cmd);
            return result;
        }


        //处理大课的最小截止日期和剩余次数
        public void DealBigCourseDeadline(Response result, Request<GetCoachRelatedFilter> req)
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
                else if (obj.CourseTypeId == CoachDic.BootcampCourse)
                {
                    obj.BigCourseMinDeadline = obj.Deadline;
                    obj.BootcampDeadline = obj.Deadline;
                    obj.BigCourseMinDeadlineCount = obj.Amount;
                }

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
