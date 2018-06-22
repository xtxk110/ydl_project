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
    /// 获取学员的约课详情
    /// </summary>
    public class GetReserveCourseDetail_186 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetCoachRelatedFilter>>(request);
            string sql = @"
SELECT 
    a.*,
    b.Name AS VenueName,
	c.Name AS CourseGoalName,
    c.Code AS CourseGoalCode,
	CoachName = dbo.fn_GetUserName(d.Id),
	BigCourseName = e.Name,
	e.Price AS BigCourseUnitPrice,
	f.Grade AS CoachGrade,
    d.Code AS CoachCode,
    b.Lng  AS VenueLng ,
    b.Lat  AS VenueLat ,
    b.Address AS VenueAddress,
    e.CourseContent AS CourseContentDetail,
    Score=(SELECT AVG(Score) FROM dbo.CoachComment WHERE CourseId=a.Id ),
	MyScore=(SELECT ISNULL(Score,0) FROM dbo.CoachComment WHERE CommentatorId=@CurrentUserId AND CourseId=a.Id )
FROM dbo.CoachCourse a
LEFT JOIN dbo.Venue b ON a.VenueId = b.Id
LEFT JOIN dbo.SysDic c ON c.Code = a.CourseGoalCode AND c.Code!=''
LEFT JOIN dbo.UserAccount d ON a.CoachId = d.Id
LEFT JOIN dbo.CoachBigCourseInfo e ON e.Id = a.BigCourseId
LEFT JOIN dbo.Coach f ON a.CoachId=f.Id
 
WHERE
     a.Id = @Id
               
";

            var cmd = CommandHelper.CreateText<CoachCourse>(FetchType.Fetch, sql);
            cmd.Params.Add("@Id", req.Filter.CourseId);
            cmd.Params.Add("@CurrentUserId", req.Filter.CurrentUserId);

            var result = DbContext.GetInstance().Execute(cmd);
            CoachCourse coachCourse = result.FirstEntity<CoachCourse>();
            if (coachCourse != null)
            {
                //获取个人信息列表
                GetPersonInfoList(coachCourse);
                //CourseName 计算赋值
                SetCourseName(coachCourse);
                //获取我的余额(界面最外层用)
                GetMyBalance(coachCourse, req.Filter.CurrentUserId);
                //获取教练或大课的单价
                GetUnitPrice(coachCourse);
                //计算课程状态
                CoachHelper.Instance.CountCourseState(coachCourse);
                //返回附件
                coachCourse.TryGetFiles();
                CoachHelper.Instance.SetCourseAvgScore(coachCourse);
            }
            return result;

        }

        /// <summary>
        /// 设置课程的评分(平均分)
        /// </summary>
        /// <param name="coachCourse"></param>
        public void SetCourseAvgScore(CoachCourse coachCourse)
        {

            var sql = @"
SELECT 
    ISNULL(AVG(Score),0) AS Score 
FROM dbo.CoachComment 
WHERE 
    CourseId=@CourseId 

";
            var cmd = CommandHelper.CreateText<CoachCourse>(FetchType.Fetch, sql);
            cmd.Params.Add("@CourseId", coachCourse.Id);
            var result = DbContext.GetInstance().Execute(cmd);
            var obj = result.FirstEntity<CoachCourse>();
            coachCourse.Score = Helper.GetRoundOffByChina(obj.Score, 2); 
        }

        public void SetCourseName(CoachCourse coachCourse)
        {
            if (coachCourse.Type == CoachDic.BigCourse)
            {
                coachCourse.CourseName = coachCourse.BigCourseName;
            }
            else if (coachCourse.Type == CoachDic.PrivateCourse)
            {
                coachCourse.CourseName = coachCourse.CoachName;
            }
            else if (coachCourse.Type == CoachDic.BootcampCourse)
            {
                var bootcamp = CoachHelper.Instance.GetCoachBootcampById(coachCourse.CoachBootcampId);
                if (bootcamp != null)
                {
                    coachCourse.CourseName = bootcamp.Name;
                }
            }
        }
        public void GetPersonInfoList(CoachCourse coachCourse)
        {
            //个人信息列表
            var list = CoachHelper.Instance.GetCoachCoursePersonInfoList(coachCourse.Id);
            foreach (CoachCoursePersonInfo item in list)
            {
                item.CourseContent = coachCourse.CourseContentDetails;
                //获取教练对学员的评价信息
                item.CoachCommentStudentInfo
                        = CoachHelper.Instance.GetStudentCommentDetail(item.Id);
                if (!string.IsNullOrEmpty(item.YdlUserId))
                {
                    SetPersonInfo(item, coachCourse);
                }

                coachCourse.CoursePersonInfoList.Add(item);
            }
        }

        /// <summary>
        /// 如果此用户是ydl用户 就设置相关余额等信息
        /// </summary>
        public void SetPersonInfo(CoachCoursePersonInfo item, CoachCourse coachCourse)
        {
            //获取基本信息
            var user = UserHelper.GetUserById(item.YdlUserId);
            if (user != null)
            {
                item.HeadUrl = user.HeadUrl;
                item.Sex = user.Sex;
                //item.StudentName = UserHelper.GetUserName(user);
            }
            //获取学员余额信息 
            GetPersonInfoBalance(coachCourse, item);
            //如果私教有训练计划的话就赋私教的训练计划内容
            if (coachCourse.Type == CoachDic.PrivateCourse)
            {
                var plan = CoachHelper.Instance.GetTrainingPlan(coachCourse.CoachId, item.YdlUserId);
                if (plan != null && !string.IsNullOrEmpty(plan.TrainingPlanContent))
                {
                    item.CourseContent = plan.TrainingPlanContent;
                }
            }
        }

        public void GetPersonInfoBalance(CoachCourse coachCourse, CoachCoursePersonInfo item)
        {
            if (coachCourse.Type == CoachDic.BigCourse)
            {
                var money = CoachHelper.Instance.GetBigCourseBalance(item.YdlUserId, coachCourse.BigCourseId);
                if (money != null)
                {
                    item.Amount = money.Amount;
                    item.ThenTotalAmount = money.ThenTotalAmount;
                }
            }
            else if (coachCourse.Type == CoachDic.PrivateCourse)
            {

                var money = CoachHelper.Instance.GetPrivateCourseBalance(item.YdlUserId, coachCourse.CoachId);
                if (money != null)
                {
                    item.Amount = money.Amount;
                    item.ThenTotalAmount = money.ThenTotalAmount;
                }

            }
        }
        public void GetMyBalance(CoachCourse coachCourse, string currentUserid)
        {
            if (coachCourse.Type == CoachDic.BigCourse)
            {
                var money = CoachHelper.Instance.GetBigCourseBalance(currentUserid, coachCourse.BigCourseId);
                if (money != null)
                {
                    coachCourse.Amount = money.Amount;
                }
            }
            else if (coachCourse.Type == CoachDic.PrivateCourse)
            {

                var money = CoachHelper.Instance.GetPrivateCourseBalance(currentUserid, coachCourse.CoachId);
                if (money != null)
                {
                    coachCourse.Amount = money.Amount;
                }

            }
            else if (coachCourse.Type == CoachDic.BootcampCourse)
            {

                var money = CoachHelper.Instance.GetBootcampBalance(currentUserid, coachCourse.CoachBootcampId);
                if (money != null)
                {

                    coachCourse.Amount = money.Amount;
                    if (money.Amount < 0)
                    {
                        coachCourse.Amount = 0;
                    }
                }
            }


        }

        public void GetUnitPrice(CoachCourse coachCourse)
        {
            coachCourse.CoachUnitPrice = CoachHelper.Instance.GetCoachUnitPrice("75", coachCourse.CoachGrade);
        }

    }


}
