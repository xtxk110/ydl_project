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
    /// 保存教练下课打卡
    /// </summary>
    public class SaveCoachEndCard_186 : IServiceBase
    {

        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<CoachCourse>>(request);
            var obj = req.FirstEntity();
            var coachCourse = CoachHelper.Instance.GetCoachCourseById(obj.Id);
            var sql = @"
 UPDATE dbo.CoachCourse
 SET 
	State=@State,
	EndCardAddress=@EndCardAddress,
	EndCardTime=@EndCardTime
WHERE Id=@Id

";
            var cmd = CommandHelper.CreateText<ClubUser>(FetchType.Execute, sql);
            cmd.Params.Add("@State", CoachDic.CourseFinished);
            cmd.Params.Add("@EndCardAddress", obj.EndCardAddress);
            cmd.Params.Add("@EndCardTime", DateTime.Now);
            cmd.Params.Add("@Id", obj.Id);

            var result = DbContext.GetInstance().Execute(cmd);
            if (result.IsSuccess)
            {
                //保存教练收入
                result = SaveCoachIncome(coachCourse);
            }
            if (result.IsSuccess)
            {
                SendJG(coachCourse.ReservedPersonId, coachCourse.Id);
            }

            result.Tag = DateTime.Now;
            return result;

        }

        private Response SaveCoachIncome(CoachCourse coachCourse)
        {
            //获取教练的收入
            var coach = CoachHelper.Instance.GetCoach(coachCourse.CoachId);
            decimal coachOriginalIncome = 0;
            decimal coachRealIncome = 0;
            if (coachCourse.Type == CoachDic.PrivateCourse)
            {
                var coachUnitPrice = CoachHelper.Instance.GetCoachUnitPrice(CoachDic.DefaultCityId, coach.Grade);
                coachOriginalIncome = coachUnitPrice * 1;
                coachRealIncome = coachUnitPrice * 1 * (coach.CommissionPercentage / 100);
            }
            else if (coachCourse.Type == CoachDic.BigCourse)
            {
                var bigUnitPrice = CoachHelper.Instance.GetBigCourseInfo(coachCourse.BigCourseId);
                if (bigUnitPrice != null)
                {
                    var studentNumber = CoachHelper.Instance.GetCoachCoursePersonInfoList(coachCourse.Id).Count;
                    coachOriginalIncome = bigUnitPrice.Price * studentNumber;
                    coachRealIncome = bigUnitPrice.Price * studentNumber * (coach.CommissionPercentage / 100);
                }
            }
            //构造实体保持教练收入
            CoachIncome obj = new CoachIncome();
            obj.CoachId = coachCourse.CoachId;
            obj.CourseId = coachCourse.Id;
            obj.CourseType = coachCourse.Type;
            obj.OriginalMoney = coachOriginalIncome;
            obj.CoachCommissionPercentage = coach.CommissionPercentage;
            obj.CoachRealIncome = coachRealIncome;
            obj.RowState = RowState.Added;
            List<EntityBase> entites = new List<EntityBase>();
            entites.Add(obj);
            obj.TrySetNewEntity();

            var result = DbContext.GetInstance().Execute(CommandHelper.CreateSave(entites));
            return result;

        }

        private void SavePrivateCoachIncome(string coachGrade)
        {
        }

        private void SaveBigcourseIncome()
        {
        }

        public void SendJG(string reserveId, string courseId)
        {
            try
            {
                Dictionary<string, object> extrasToStudent = new Dictionary<string, object>();
                extrasToStudent.Add("Type", SystemMessageType.StudentReservedCourseDetail);
                extrasToStudent.Add("BusinessId", courseId);
                extrasToStudent.Add("Message", "课程已结束, 请评价");
                JPushHelper.SendCourseSystemMessage(extrasToStudent, reserveId);
            }
            catch (Exception)
            {

            }

        }

    }
}
