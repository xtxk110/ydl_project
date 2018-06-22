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
    ///教学管理员 修改约课(包含大课私教)
    /// </summary>
    public class TeachManagerUpdateReserveCourse_187 : IServiceBase
    {

        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<CoachCourse>>(request);
            var obj = req.FirstEntity();
            string errorMsg;

            //课程进行中或已完成, 不能修改
            var oldCoachCourse = CoachHelper.Instance.GetCoachCourseById(obj.Id);
            if (oldCoachCourse.State != CoachDic.CourseNotStart)
            {
                return ResultHelper.Fail("课程进行中或已完成, 不能修改!");
            }


            //判断时间是否有效 
            errorMsg = CoachHelper.Instance.CheckTimeValid(obj.BeginTime, obj.EndTime);
            if (errorMsg != "")
            {
                return ResultHelper.Fail(errorMsg);
            }

            //私教判断课程时间范围是否和已有的重合
            if (!string.IsNullOrEmpty(obj.CoachId) && obj.Type == CoachDic.PrivateCourse)
            {
                if (IsRepeatPeriodInPrivateCoach(obj))
                {
                    return ResultHelper.Fail("教练这个时间段有课, 请修改时间范围再约 ");
                }
            }

            var sql = @"
UPDATE dbo.CoachCourse
SET 
	BeginTime=@BeginTime,
	EndTime=@EndTime,
    VenueId=@VenueId,
    CoachId=@CoachId
WHERE Id=@Id
";
            var cmd = CommandHelper.CreateText<CoachCourse>(FetchType.Execute, sql);
            cmd.Params.Add("@BeginTime", obj.BeginTime);
            cmd.Params.Add("@EndTime", obj.EndTime);
            cmd.Params.Add("@CoachId", obj.CoachId);
            cmd.Params.Add("@VenueId", obj.VenueId);
            cmd.Params.Add("@Id", obj.Id);

            var result = DbContext.GetInstance().Execute(cmd);

            if (result.IsSuccess == true)
            {
                //极光推送
                SendJG(oldCoachCourse.ReservedPersonId, oldCoachCourse.CoachId, oldCoachCourse.Id, currentUser.Id);
            }

            return result;

        }


        public void SendJG(string reserveId, string coachId, string courseId, string currentUserId)
        {

            try
            {
                var user = UserHelper.GetUserById(reserveId);
                var studentName = UserHelper.GetUserName(user);

                //教学管理员, 给学员和教练都发系统消息
                //发给教练
                string message = string.Format("[教学管理员]修改了你的课程预约, 请查看");
                Dictionary<string, object> extrasToCoach = new Dictionary<string, object>();
                extrasToCoach.Add("Type", SystemMessageType.CoachReservedCourseDetail);
                extrasToCoach.Add("BusinessId", courseId);
                extrasToCoach.Add("Message", message);
                JPushHelper.SendCourseSystemMessage(extrasToCoach, coachId);
                //发给学员
                Dictionary<string, object> extrasToStudent = new Dictionary<string, object>();
                extrasToStudent.Add("Type", SystemMessageType.StudentReservedCourseDetail);
                extrasToStudent.Add("BusinessId", courseId);
                extrasToStudent.Add("Message", message);
                JPushHelper.SendCourseSystemMessage(extrasToStudent, reserveId);



            }
            catch (Exception)
            {
            }

        }




        /// <summary>
        /// 判断课程时间范围是否重合
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
        public bool IsRepeatPeriodInPrivateCoach(CoachCourse obj)
        {
            //此算法来源于 SO 的牛b算法, 当时本人写了几百行代码都没解决, SO 大神一句就搞定了, 膜拜
            //http://stackoverflow.com/questions/13513932/algorithm-to-detect-overlapping-periods

            var sql = @"
SELECT 
    COUNT(*) 
FROM dbo.CoachCourse 
WHERE   @BeginTime < EndTime AND BeginTime < @EndTime
        AND CoachId=@CoachId AND State!=@State
";
            if (obj.RowState == RowState.Modified)
            {
                sql += " AND Id!=@Id ";  //如果是修改操作, 把自己(修改记录)剔除掉判断 . 如果是添加操作, 所有记录参与判断
            }
            var cmdVal = CommandHelper.CreateText<ClubUser>(FetchType.Scalar, sql);
            cmdVal.Params.Add("@BeginTime", obj.BeginTime);
            cmdVal.Params.Add("@EndTime", obj.EndTime);
            cmdVal.Params.Add("@CoachId", obj.CoachId);
            cmdVal.Params.Add("@State", CoachDic.CourseFinished);

            if (obj.RowState == RowState.Modified)
            {
                cmdVal.Params.Add("@Id", obj.Id);
            }
            var result = DbContext.GetInstance().Execute(cmdVal);
            if ((int)result.Tag == 1)
            {
                return true;
            }
            else
            {
                return false;
            }

        }
 


    }
}
