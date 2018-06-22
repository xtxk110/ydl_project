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
    /// 获取教练下学员列表(不传教练Id是获取所有学员)
    /// </summary>
    public class GetCoachStudentList_186 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetCoachRelatedFilter>>(request);
            //先获取教练有哪些学员
            var cmd = CommandHelper.CreateProcedure<CoachStudentMoney>(text: "GetCoachStudentList");
            cmd.Params.Add("@CoachId", req.Filter.CoachId);//(不传教练Id是获取所有学员)
            cmd.Params.Add("@Name", req.Filter.StudentName);
            cmd.CreateParamPager(req.Filter);

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();

            List<CoachStudent> studentList = new List<CoachStudent>();
            foreach (var item in result.Entities)
            {
                CoachStudent coachStudent = new CoachStudent();
                var StudentUserId = (item as CoachStudentMoney).StudentUserId;
                //获取学员的基本信息
                var user = UserHelper.GetUserById(StudentUserId);
                if (user == null)
                {
                    continue;
                }
                coachStudent.HeadUrl = user.HeadUrl;
                coachStudent.Name = UserHelper.GetUserName(user);
                coachStudent.Sex = user.Sex;
                coachStudent.Id = StudentUserId;
                //获取学员的余额信息
                GetBalance(coachStudent, StudentUserId, req.Filter.CoachId);
                studentList.Add(coachStudent);
            }
            result.Entities.Clear();
            result.Entities.AddRange(studentList);
            return result;

        }


        public void GetBalance(CoachStudent coachStudent, string StudentUserId, string coachId)
        {
            //取大课的余额
            var bigCourseId = GetBigCourseId(StudentUserId, coachId);
            if (!string.IsNullOrEmpty(bigCourseId))
            {
                var moneyObj = CoachHelper.Instance.GetBigCourseBalance(StudentUserId, bigCourseId);
                if (moneyObj != null)
                {
                    CoachStudentBalance coachStudentBalance = new CoachStudentBalance();
                    coachStudentBalance.Amount = moneyObj.Amount;
                    coachStudentBalance.TotalAmount = moneyObj.ThenTotalAmount;
                    //取大课最后一次上课日期
                    coachStudentBalance.LastGoCourseTime =CoachHelper.Instance.GetLastGoCourseTime(StudentUserId, CoachDic.BigCourse);
                    coachStudent.BigCourseBalance = coachStudentBalance;
                }
            }
            //取私教的余额
            var moneyObjPrivate = CoachHelper.Instance.GetPrivateCourseBalance(StudentUserId, coachId);
            if (moneyObjPrivate != null)
            {
                CoachStudentBalance coachStudentBalance = new CoachStudentBalance();
                coachStudentBalance.Amount = moneyObjPrivate.Amount;
                coachStudentBalance.TotalAmount = moneyObjPrivate.ThenTotalAmount;
                //取大课最后一次上课日期
                coachStudentBalance.LastGoCourseTime =CoachHelper.Instance.GetLastGoCourseTime(StudentUserId, CoachDic.PrivateCourse);
                coachStudent.PrivateCourseBalance = coachStudentBalance;

            }

            //取集训班的余额
            var moneyObjBootcamp = CoachHelper.Instance.GetBootcampAllBalance(StudentUserId);
            if (moneyObjBootcamp != null)
            {
                CoachStudentBalance coachStudentBalance = new CoachStudentBalance();
                coachStudentBalance.Amount = moneyObjBootcamp.Amount;
                coachStudentBalance.TotalAmount = moneyObjBootcamp.ThenTotalAmount;
                coachStudentBalance.LastGoCourseTime = CoachHelper.Instance.GetLastGoCourseTimeInBootcamp(StudentUserId, CoachDic.BootcampCourse);
                coachStudent.CoachBootcampBalance = coachStudentBalance;

            }
            

        }

        

        public string GetBigCourseId(string StudentUserId, string coachId)
        {
            var sql = @"
 SELECT 
	BigCourseId 
 FROM dbo.CoachCourse
 WHERE  ReservedPersonId=@ReservedPersonId
	AND Type=@CourseTypeId

";
            var cmd = CommandHelper.CreateText<CoachCourse>(FetchType.Fetch, sql);
            cmd.Params.Add("@CoachId", coachId);
            cmd.Params.Add("@ReservedPersonId", StudentUserId);
            cmd.Params.Add("@CourseTypeId", CoachDic.BigCourse);
            var result = DbContext.GetInstance().Execute(cmd);
            var obj = result.FirstEntity<CoachCourse>();
            if (obj != null)
            {
                return obj.BigCourseId;
            }
            return "";
        }

    }
}
