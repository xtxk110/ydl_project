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
    /// 获取教练端课程详情
    /// </summary>
    public class GetCoachCourseDetail_186 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetCoachRelatedFilter>>(request);
            string sql = @"
SELECT 
    a.*,
    b.Name AS VenueName,
	c.Name AS CourseGoalName,
	CoachName = dbo.fn_GetUserName(d.Id),
	BigCourseName = e.Name,
	f.Name AS TypeName,
	b.Address AS VenueAddress,
    e.CourseContent AS CourseContentDetail
FROM dbo.CoachCourse a
LEFT JOIN dbo.Venue b ON a.VenueId = b.Id
LEFT JOIN dbo.SysDic c ON c.Code = a.CourseGoalCode AND c.Code!=''
LEFT JOIN dbo.UserAccount d ON a.CoachId = d.Id
LEFT JOIN dbo.CoachBigCourseInfo e ON e.Id = a.BigCourseId
LEFT JOIN dbo.BaseData f ON a.Type=f.Id
WHERE
     a.Id = @Id
               
";
            var cmd = CommandHelper.CreateText<CoachCourse>(FetchType.Fetch, sql);
            cmd.Params.Add("@Id", req.Filter.CourseId);
            var result = DbContext.GetInstance().Execute(cmd);

            CoachCourse coachCourse = result.FirstEntity<CoachCourse>();
            if (coachCourse != null)
            {
                //个人信息列表
                GetPersonInfoList(coachCourse);
                //CourseName 计算赋值
                if (coachCourse.Type == CoachDic.BigCourse)
                {
                    coachCourse.CourseName = coachCourse.BigCourseName;
                }
                else if (coachCourse.Type == CoachDic.PrivateCourse)
                {
                    coachCourse.CourseName = coachCourse.CoachName;
                }

                //计算上下课打卡按钮状态
                CountStartEndCard(coachCourse);
                //获取附件
                coachCourse.TryGetFiles();
            }

            return result;

        }

        /// <summary>
        /// 计算上下课打卡按钮状态
        /// </summary>
        public void CountStartEndCard(CoachCourse coachCourse)
        {
            if (coachCourse.State == CoachDic.CourseNotStart)
            {
                coachCourse.IsStartCard = false;
                coachCourse.IsEndCard = false;
            }
            else if (coachCourse.State == CoachDic.CourseProcessing)
            {
                coachCourse.IsStartCard = true;
                coachCourse.IsEndCard = false;
            }
            else if (coachCourse.State == CoachDic.CourseFinished)
            {
                coachCourse.IsStartCard = true;
                coachCourse.IsEndCard = true;
            }

        }
        //获取学员列表
        public void GetPersonInfoList(CoachCourse coachCourse)
        {
            var list = CoachHelper.Instance.GetCoachCoursePersonInfoList(coachCourse.Id);
            foreach (CoachCoursePersonInfo item in list)
            {
                item.Sex = "1";//默认给 1
                item.CourseType = coachCourse.Type;
                item.CourseContent = coachCourse.CourseContentDetails;

                //获取教练对学员的评价信息
                item.CoachCommentStudentInfo = CoachHelper.Instance.GetStudentCommentDetail(item.Id);
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
            //获取余额信息
            GetBalance(coachCourse, item);
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



        public void GetBalance(CoachCourse coachCourse, CoachCoursePersonInfo item)
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
            else if (coachCourse.Type == CoachDic.BootcampCourse)
            {
                var money = CoachHelper.Instance.GetBootcampBalance(item.YdlUserId, coachCourse.CoachBootcampId);
                if (money != null)
                {
                    item.Amount = money.Amount;
                    item.ThenTotalAmount = money.ThenTotalAmount;
                }
            }
        }




    }


}
