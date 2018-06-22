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
    /// 获取约课历史信息
    /// </summary>
    public class GetReserveCourseHistoryInfo_186 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetCoachRelatedFilter>>(request);
            Response rsp = new Response();
            rsp = GetCourseHistory(req);
            rsp.IsSuccess = true;
            return rsp;


        }
        /// <summary>
        /// 业务逻辑:
        /// 读取优先级:上次约课记录 -> 购买时记录
        /// </summary>
        /// <returns></returns>
        public Response GetCourseHistory(Request<GetCoachRelatedFilter> req)
        {
            Response rsp = new Response();
            //先检查有木有上次约课记录
            var previousRecord = GetPreviousRecord(req.Filter.CurrentUserId, req.Filter.CourseTypeId, req.Filter.CourseNameId);
            if (previousRecord != null)
            {
                previousRecord.CourseNameId = req.Filter.CourseNameId;
                rsp.Entities.Add(previousRecord);//有就返回上次约课记录
                return rsp;
            }

            //没有约课记录, 就读取购买时的个人信息记录(这个始终是有值的)
            var buyRecord = GetPreviousBuyRecord(req.Filter.CurrentUserId, req.Filter.CourseTypeId, req.Filter.CourseNameId);
            buyRecord.CourseNameId = req.Filter.CourseNameId;
            rsp.Entities.Add(buyRecord);
            return rsp;

        }

        //获取之前的购买记录
        public CoachCourse GetPreviousBuyRecord(string reservedPersonId, string courseType, string courseNameId)
        {
            string sql = "";
            if (courseType == CoachDic.BigCourse)
            {
                sql = @"
SELECT 
  TOP 1
	a.*,
	b.Name AS VenueName,
	c.Name AS CourseGoalName
  FROM dbo.CoachStudentMoney a
  LEFT JOIN dbo.Venue b ON a.VenueId =b.Id
  LEFT JOIN dbo.SysDic c ON a.CourseGoalCode=c.Code AND c.Code!=''
  WHERE BigCourseInfoId=@BigCourseInfoId 
		AND StudentUserId=@StudentUserId
 ORDER BY a.CreateDate DESC 

 ";

            }
            else if (courseType == CoachDic.PrivateCourse)
            {
                sql = @"
SELECT 
    TOP 1
	a.*,
	b.Name AS VenueName,
	c.Name AS CourseGoalName,
	d.Code AS CoachCode
  FROM dbo.CoachStudentMoney a
  LEFT JOIN dbo.Venue b ON a.VenueId =b.Id
  LEFT JOIN dbo.SysDic c ON a.CourseGoalCode=c.Code AND c.Code!=''
  LEFT JOIN dbo.UserAccount d ON a.CoachId=d.Id
  WHERE a.CoachId=@CoachId 
		AND StudentUserId=@StudentUserId
 ORDER BY a.CreateDate DESC 
 ";
            }

            var cmd = CommandHelper.CreateText<CoachStudentMoney>(FetchType.Fetch, sql);
            cmd.Params.Add("@BigCourseInfoId", courseNameId);
            cmd.Params.Add("@StudentUserId", reservedPersonId);
            cmd.Params.Add("@CoachId", courseNameId);
            var result = DbContext.GetInstance().Execute(cmd);
            CoachStudentMoney coachStudentMoney = result.FirstEntity<CoachStudentMoney>();
            CoachCourse coachCourse = new CoachCourse();
            if (coachStudentMoney != null)
            {
                //获取 CoachCourse对象信息
                coachCourse.VenueId = coachStudentMoney.VenueId;
                coachCourse.VenueName = coachStudentMoney.VenueName;
                coachCourse.StudentRemark = coachStudentMoney.StudentRemark;
                coachCourse.CourseGoalCode = coachStudentMoney.CourseGoalCode;
                coachCourse.CourseGoalName = coachStudentMoney.CourseGoalName;
                coachCourse.Type = coachStudentMoney.CourseTypeId;
                coachCourse.CoachCode = coachStudentMoney.CoachCode;
                coachCourse.CoachId = coachStudentMoney.CoachId;
                coachCourse.BigCourseId = coachStudentMoney.BigCourseInfoId;
                //获取CoachCoursePersonInfo对象信息
                CoachCoursePersonInfo coachCoursePersonInfo = new CoachCoursePersonInfo();
                var frequentStudentObj = GetFrequentStudent(coachStudentMoney.FrequentStudentId);
                if (frequentStudentObj != null)
                {
                    coachCoursePersonInfo.FrequentStudentId = frequentStudentObj.Id;
                    coachCoursePersonInfo.StudentName = frequentStudentObj.Name;
                    coachCoursePersonInfo.StudentMobile = frequentStudentObj.Mobile;
                    coachCourse.CoursePersonInfoList.Add(coachCoursePersonInfo);
                }
     
            }
            return coachCourse;
        }


        public CoachFrequentStudent GetFrequentStudent(string FrequentStudentId)
        {
            string sql = @"
 SELECT 
    * 
 FROM dbo.CoachFrequentStudent
 WHERE Id=@Id

";

            var cmd = CommandHelper.CreateText<CoachFrequentStudent>(FetchType.Fetch, sql);
            cmd.Params.Add("@Id", FrequentStudentId);

            var result = DbContext.GetInstance().Execute(cmd);
            return result.FirstEntity<CoachFrequentStudent>();

        }
        //获取上次约课记录
        public CoachCourse GetPreviousRecord(string reservedPersonId, string courseType, string courseNameId)
        {
            string sql = "";
            if (courseType == CoachDic.BigCourse)
            {
                sql = @"
SELECT 
    TOP 1 
    a.*,
    b.Name AS VenueName,
	c.Name AS CourseGoalName,
	d.Code AS CoachCode
FROM dbo.CoachCourse a
LEFT JOIN dbo.Venue b ON a.VenueId =b.Id
LEFT JOIN dbo.SysDic c ON c.Code=a.CourseGoalCode AND c.Code!=''
LEFT JOIN dbo.UserAccount d ON a.CoachId=d.Id
WHERE 
    a.BigCourseId = @BigCourseId AND a.ReservedPersonId = @ReservedPersonId
    AND a.Type='027001'
ORDER BY a.CreateDate DESC 

 ";

            }
            else if (courseType == CoachDic.PrivateCourse)
            {
                sql = @"
SELECT 
    TOP 1 
     a.*,
     b.Name AS VenueName,
	 c.Name AS CourseGoalName,
	 d.Code AS CoachCode
 FROM dbo.CoachCourse a
 LEFT JOIN dbo.Venue b ON a.VenueId=b.Id
 LEFT JOIN dbo.SysDic c ON a.CourseGoalCode=c.Code  AND c.Code!=''
 LEFT JOIN dbo.UserAccount d ON a.CoachId=d.Id
 WHERE a.CoachId=@CoachId AND a.ReservedPersonId=@ReservedPersonId
        AND a.Type='027003'
 ORDER BY a.CreateDate DESC 


 ";
            }

            var cmd = CommandHelper.CreateText<CoachCourse>(FetchType.Fetch, sql);
            cmd.Params.Add("@BigCourseId", courseNameId);
            cmd.Params.Add("@ReservedPersonId", reservedPersonId);
            cmd.Params.Add("@CoachId", courseNameId);
            var result = DbContext.GetInstance().Execute(cmd);
            CoachCourse coachCourse = result.FirstEntity<CoachCourse>();
            if (coachCourse != null)
            {
                var list = CoachHelper.Instance.GetCoachCoursePersonInfoList(coachCourse.Id);
                if (list.Count > 0)
                {
                    coachCourse.CoursePersonInfoList.AddRange(list);
                }
            }
            return coachCourse;
        }


    }


}
