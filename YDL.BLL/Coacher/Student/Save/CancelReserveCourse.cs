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
    /// 取消约课(包含大课私教)
    /// </summary>
    public class CancelReserveCourse_186 : IServiceBase
    {

        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<CoachCourse>>(request);
            var obj = req.FirstEntity();
            var coachCourse = CoachHelper.Instance.GetCoachCourseById(obj.Id);
            if (coachCourse.BeginTime==null)
            {
                return ResultHelper.Fail("没有找到可以取消的课程");
            }
            //距离上课时间小于四个小时,不能修改
            var beginTime = (DateTime)coachCourse.BeginTime;
            if (beginTime > DateTime.Now)
            {
                var legalTime = DateTime.Now.AddHours(4);

                //TimeSpan timeSpan = ((DateTime)coachCourse.BeginTime).Subtract(DateTime.Now);
                if (legalTime >= beginTime)
                {
                    return ResultHelper.Fail("距离上课时间小于四个小时,不能取消");
                }
            }

            //课程进行中或已完成, 不能取消预约
            if (coachCourse.State != CoachDic.CourseNotStart)
            {
                return ResultHelper.Fail("课程进行中或已完成, 不能取消预约!");
            }
            var list = GetPersonInfoListByCourseId(obj.Id);//提前获取到数据不然删除了就没有了
            var sql = @"
 DELETE FROM dbo.CoachCourse WHERE Id=@Id
 DELETE FROM dbo.CoachCoursePersonInfo WHERE CourseId=@Id
";
            var cmd = CommandHelper.CreateText<ClubUser>(FetchType.Execute, sql);
            cmd.Params.Add("@Id", obj.Id);

            var result = DbContext.GetInstance().Execute(cmd);

            //返回余额
            if (result.IsSuccess == true)
            {

                foreach (var item in list)
                {
                    //有多少个人头就返回多少次
                    result = CoachHelper.Instance.AddOne(obj);
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
                //发送短信
                qcloudsms_csharp.SmsSingleSenderResult smsResult= SmsHelper.SendCourseSms(currentUser,obj, CoursePersonType.Coacher, CourseSmsType.Cancel);//发给教练
                qcloudsms_csharp.SmsSingleSenderResult smsResult1=SmsHelper.SendCourseSms(currentUser,obj, CoursePersonType.Student, CourseSmsType.Cancel);//发给学生
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
                if (currentUserId != SystemDic.SystemManagerId)//普通用户
                {
                    //普通用户, 给教练 发系统消息
                    Dictionary<string, object> extras = new Dictionary<string, object>();
                    extras.Add("Type", SystemMessageType.DoNotJump);
                    extras.Add("Message", string.Format("[{0}]取消了对你课程的预约", studentName));
                    JPushHelper.SendCourseSystemMessage(extras, coachId);
                }
                else if (currentUserId == SystemDic.SystemManagerId)
                {
                    //系统管理员, 给学员和教练都发系统消息
                    //发给教练
                    string message = string.Format("[系统管理员]取消了你课程的预约");
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
            }
            catch (Exception)
            {
            }
        }




    }
}
