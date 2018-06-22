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
    /// 修改约课(包含大课私教)
    /// </summary>
    public class UpdateReserveCourse_186 : IServiceBase
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

            //距离上课时间小于四个小时,不能修改
            var beginTime = (DateTime)oldCoachCourse.BeginTime;
            if (beginTime > DateTime.Now)
            {
                var legalTime = DateTime.Now.AddHours(4);

                //TimeSpan timeSpan = beginTime.Subtract(DateTime.Now);
                if (legalTime >= beginTime)
                {
                    return ResultHelper.Fail("距离上课时间小于四个小时,不能修改");
                }
            }


            //判断时间是否有效 
            errorMsg = CoachHelper.Instance.CheckTimeValid(obj.BeginTime, obj.EndTime);
            if (errorMsg != "")
            {
                return ResultHelper.Fail(errorMsg);
            }

            //私教判断课程时间范围是否和已有的重合
            if (!string.IsNullOrEmpty(obj.CoachId))//有教练Id时
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
    Remark=@Remark
WHERE Id=@Id
";
            var cmd = CommandHelper.CreateText<CoachCourse>(FetchType.Execute, sql);
            cmd.Params.Add("@BeginTime", obj.BeginTime);
            cmd.Params.Add("@EndTime", obj.EndTime);
            cmd.Params.Add("@Remark", obj.Remark);
            cmd.Params.Add("@Id", obj.Id);

            var result = DbContext.GetInstance().Execute(cmd);
            //返还或者扣除次数
            if (result.IsSuccess == true)
            {
                result = AddOrSubAmount(result, oldCoachCourse, obj);
            }
            if (result.IsSuccess == true)
            {
                DeleteCoursePersonInfo(obj);//先删除以前的数据
                result = SaveCoursePersonInfoList(obj);//再保存新的约课人信息
            }

            if (result.IsSuccess == true)
            {
                //极光推送
                SendJG(oldCoachCourse.ReservedPersonId, oldCoachCourse.CoachId, oldCoachCourse.Id, currentUser.Id);
                //发送短信
                obj.CoachId = oldCoachCourse.CoachId;//把查询出来的教练用户id赋值到OBJ
                SmsHelper.SendCourseSms(currentUser,obj, CoursePersonType.Coacher, CourseSmsType.Update);//发给教练
                SmsHelper.SendCourseSms(currentUser,obj, CoursePersonType.Student, CourseSmsType.Update);//发给学生
            }

            return result;

        }

        /// <summary>
        /// 返还或者扣除次数
        /// 业务逻辑: 根据以前的人头数和这次修改的人头数做比较, 
        ///     然后得到差值(比如2次), 通过差值(比如2次)返还2次或者扣除2次
        /// </summary>
        /// <param name="oldCoachCourse"></param>
        /// <param name="updateObj"></param>
        /// <returns></returns>
        public Response AddOrSubAmount(Response response, CoachCourse oldCoachCourse, CoachCourse updateObj)
        {
            var personInfoList = CoachHelper.Instance.GetCoachCoursePersonInfoList(oldCoachCourse.Id);
            int oldCount = personInfoList.Count;//之前的人数
            int newCount = updateObj.CoursePersonInfoList.Count;
            int subValue = oldCount - newCount;
            if (subValue == 0)
            {
                //不做任何操作
                return response;
            }
            else if (subValue > 0)
            {
                //返还次数
                for (int i = 0; i < subValue; i++)
                {
                    response = CoachHelper.Instance.AddOne(oldCoachCourse);
                }
            }
            else if (subValue < 0)
            {
                subValue = Math.Abs(subValue);
                //扣除次数
                for (int i = 0; i < subValue; i++)
                {
                    response = CoachHelper.Instance.SubOne(oldCoachCourse);
                }
            }
            return response;
        }

        public void SendJG(string reserveId, string coachId, string courseId, string currentUserId)
        {

            try
            {
                var user = UserHelper.GetUserById(reserveId);
                var studentName = UserHelper.GetUserName(user);
                if (currentUserId != SystemDic.SystemManagerId)//普通用户
                {
                    //普通用户, 给教练 发系统消息
                    Dictionary<string, object> extras = new Dictionary<string, object>();
                    extras.Add("Type", SystemMessageType.CoachReservedCourseDetail);
                    extras.Add("BusinessId", courseId);
                    extras.Add("Message", string.Format("[{0}]修改了对你课程的预约, 请查看", studentName));
                    JPushHelper.SendCourseSystemMessage(extras, coachId);
                }
                else if (currentUserId == SystemDic.SystemManagerId)
                {
                    //系统管理员, 给学员和教练都发系统消息
                    //发给教练
                    string message = string.Format("[系统管理员]修改了你的课程预约, 请查看");
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


            }
            catch (Exception)
            {
            }

        }

        public Response DeleteCoursePersonInfo(CoachCourse obj)
        {

            var sql = @"
DELETE FROM dbo.CoachCoursePersonInfo  WHERE CourseId=@CourseId
";

            var cmdVal = CommandHelper.CreateText<ClubUser>(FetchType.Scalar, sql);
            cmdVal.Params.Add("@CourseId", obj.Id);
            var result = DbContext.GetInstance().Execute(cmdVal);
            return result;
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

        public Response SaveCoursePersonInfoList(CoachCourse obj)
        {
            Response rsp = new Response();
            List<EntityBase> entites = new List<EntityBase>();
            foreach (var item in obj.CoursePersonInfoList)
            {
                item.CourseId = obj.Id;
                item.RowState = RowState.Added;
                item.TrySetNewEntity();
                entites.Add(item);
            }
            if (entites.Count > 0)
            {
                rsp = DbContext.GetInstance().Execute(CommandHelper.CreateSave(entites));
            }
            return rsp;
        }



    }
}
