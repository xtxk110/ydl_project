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
    /// 教学管理员 取消约课(包含大课私教)
    /// </summary>
    public class TeachManagerCancelReserveCourse_187 : IServiceBase
    {

        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<CoachCourse>>(request);
            var obj = req.FirstEntity();
            var coachCourse = CoachHelper.Instance.GetCoachCourseById(obj.Id);

            //课程进行中或已完成, 不能取消
            if (coachCourse.State != CoachDic.CourseNotStart)
            {
                return ResultHelper.Fail("课程进行中或已完成, 不能取消!");
            }

            var list = GetPersonInfoListByCourseId(coachCourse.Id);//提前获取到数据不然删除了就没有了
            var sql = @"
 DELETE FROM dbo.CoachCourse WHERE Id=@Id
 DELETE FROM dbo.CoachCoursePersonInfo WHERE CourseId=@Id
";
            var cmd = CommandHelper.CreateText<ClubUser>(FetchType.Execute, sql);
            cmd.Params.Add("@Id", coachCourse.Id);

            var result = DbContext.GetInstance().Execute(cmd);

            //返回余额
            if (result.IsSuccess == true)
            {

                foreach (var item in list)
                {
                    //有多少个人头就返回多少次
                    result = CoachHelper.Instance.AddOne(coachCourse);
                    if (result.IsSuccess == false)
                    {
                        break;
                    }
                }

            }

            if (result.IsSuccess == true)
            {
                //极光推送
                SendJG(coachCourse.ReservedPersonId, coachCourse.CoachId, currentUser.Id);
            }
            return result;

        }

        public List<CoachCoursePersonInfo> GetPersonInfoListByCourseId(string courseId)
        {
            var sql = @"
 SELECT * FROM dbo.CoachCoursePersonInfo WHERE CourseId=@CourseId
";
            var cmd = CommandHelper.CreateText<CoachCoursePersonInfo>(FetchType.Fetch, sql);
            cmd.Params.Add("@CourseId", courseId);
            var result = DbContext.GetInstance().Execute(cmd);
            return result.Entities.ToList<EntityBase, CoachCoursePersonInfo>();
        }

        public void SendJG(string reserveId, string coachId, string currentUserId)
        {

            try
            {

                var user = UserHelper.GetUserById(reserveId);
                var studentName = UserHelper.GetUserName(user);
                //教学管理员, 给学员和教练都发系统消息
                //发给教练
                string message = string.Format("[教学管理员]取消了你课程的预约");
                Dictionary<string, object> extrasToCoach = new Dictionary<string, object>();
                extrasToCoach.Add("Type", SystemMessageType.DoNotJump);
                extrasToCoach.Add("Message", message);
                JPushHelper.SendCourseSystemMessage(extrasToCoach, coachId);
                //发给学员
                Dictionary<string, object> extrasToStudent = new Dictionary<string, object>();
                extrasToStudent.Add("Type", SystemMessageType.DoNotJump);
                extrasToStudent.Add("Message", message);
                JPushHelper.SendCourseSystemMessage(extrasToStudent, reserveId);
            }
            catch (Exception)
            {
            }
        }




    }
}
