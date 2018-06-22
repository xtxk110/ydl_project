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
    /// 课程详情-- 确认课程结束
    /// </summary>
    public class SaveCoachCourseEnd : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<CoachCourse>>(request);
            var obj = req.FirstEntity();
            Response result = new Response();
            //先插入学员的点评数据
            result = SaveCourseStudentRemark(obj.CoachStudentRemarkList);
            if (result.IsSuccess == false)
            {
                return result;
            }

            //再插入教练收入 数据
            var errorMsg = InsertCoachIncome(obj.Id, obj.StudentNumber);
            if (errorMsg != "")
            {
                result.IsSuccess = false;
                result.Message = errorMsg;
                return result;
            }

            //再更改课程的状态
            var sql = @" 
 UPDATE dbo.CoachCourse 
 SET CourseSummary=@CourseSummary,
        State=@State
 WHERE Id=@Id
";
            var cmd = CommandHelper.CreateText(FetchType.Execute, sql);
            cmd.Params.Add("@Id", obj.Id);
            cmd.Params.Add("@CourseSummary", obj.CourseSummary);
            cmd.Params.Add("@State", CoachDic.CourseFinished);

            result = DbContext.GetInstance().Execute(cmd);

            return result;
        }

        /// <summary>
        /// 保存课程学员点评
        /// </summary>
        /// <returns></returns>
        public Response SaveCourseStudentRemark(List<CoachStudentRemark> list)
        {
            Response result = new Response();
            foreach (var obj in list)
            {
                List<EntityBase> entites = new List<EntityBase>();
                entites.Add(obj);
                obj.RowState = RowState.Added;
                if (obj.RowState == RowState.Added)
                {
                    obj.TrySetNewEntity();
                }
                result = DbContext.GetInstance().Execute(CommandHelper.CreateSave(entites));
                if (result.IsSuccess == false)
                {
                    return result;
                }
            }

            return result;
        }

        /// <summary>
        /// 插入 教练收入 原始数据, 供后面教练收入统计用
        /// </summary>
        public string InsertCoachIncome(string courseId, int studentNumber)
        {
            var courseInfo = GetCourseInfo(courseId).FirstEntity<CoachCourse>();
            if (courseInfo == null)
            {
                return "未获取到课程信息, 不能结束课程";
            }

            //组装 教练收入数据
            var obj = new CoachIncome();
            obj.CoachId = courseInfo.CoachId;
            obj.StudentId = courseInfo.StudentId;
            obj.CourseId = courseInfo.Id;
            obj.CourseType = courseInfo.Type;


            obj.OriginalMoney = GetCourseTotalMoney(courseId);  // 一节课总收入
            // 教练一节课实际收入=一节课总收入 * 教练分成比例
            obj.CoachRealIncome = obj.OriginalMoney
                * (courseInfo.CoachCommissionPercentage / 100);
            // 机构一节课实际收入=一节课总收入 *(1- 教练分成比例)* 机构分成比例(机构的分成比例是和我们悦动力的结算比例)
            obj.OrganizationRealIncome = obj.OriginalMoney
                * (1 - courseInfo.CoachCommissionPercentage / 100)
                * (courseInfo.OrganizationCommissionPercentage / 100);

            obj.CoachCommissionPercentage = courseInfo.CoachCommissionPercentage; //教练分成比例
            obj.OrganizationCommissionPercentage = courseInfo.OrganizationCommissionPercentage; //机构分成比例
            obj.RowState = RowState.Added;
            //插入 教练收入数据
            List<EntityBase> entites = new List<EntityBase>();
            entites.Add(obj);
            obj.TrySetNewEntity();
            var result = DbContext.GetInstance().Execute(CommandHelper.CreateSave(entites));
            if (result.IsSuccess == false)
            {
                return result.Message;
            }

            return "";

        }

        public decimal GetCourseTotalMoney(string courseId)
        {
            var studentList = CoachHelper.GetStudentList(courseId);
            decimal totalMoney = 0;
            foreach (var item in studentList)
            {
                totalMoney += item.ThenCourseUnitPrice;
            }
            return totalMoney;
        }

        //取课程信息 和 教练信息 
        public Response GetCourseInfo(string courseId)
        {
            var sql = @"
 SELECT 
		a.CoachId,
		a.Id,
		a.Type,
		b.CommissionPercentage AS CoachCommissionPercentage,
		b.Grade AS CoachGrade,
		c.CommissionPercentage AS OrganizationCommissionPercentage
FROM dbo.CoachCourse a
INNER JOIN dbo.Coach b ON a.CoachId=b.Id
LEFT JOIN dbo.CoachOrganization c ON b.OrganizationId=c.Id
WHERE a.Id=@CourseId

";
            var cmd = CommandHelper.CreateText<CoachCourse>(FetchType.Fetch, sql);
            cmd.Params.Add("@CourseId", courseId);
            var result = DbContext.GetInstance().Execute(cmd);
            return result;

        }



    }
}
