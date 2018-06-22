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
    /// 保存集训的学员
    /// </summary>
    public class SaveSealedBootcampStudent_189 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<CoachStudent>>(request);
            //实体转换
            List<CoachBootcampStudent> studentList = new List<CoachBootcampStudent>();
            foreach (var item in req.Entities)
            {
                CoachBootcampStudent student = new CoachBootcampStudent();
                var coachStudent = item as CoachStudent;
                student.CoachBootcampId = coachStudent.CoachBootcampId;
                student.StudentId = coachStudent.UserId;
                student.RowState = coachStudent.RowState;
                studentList.Add(student);
            }
            //开始业务逻辑操作
            Response rsp = ResultHelper.CreateResponse();
            var studentObj = req.FirstEntity();
            if (studentObj.RowState == RowState.Added)//添加
            {

                foreach (var obj in studentList)
                {
                    //先检查是否已添加
                    var student = GetCoachBootcampStudent(obj);
                    if (student != null)
                    {
                        return ResultHelper.Fail("学员:[ " + student.StudentName + " ]已添加,不能再添加");
                    }
                    //再添加
                    var bootcamp = CoachHelper.Instance.GetCoachBootcampById(obj.CoachBootcampId);
                    if (bootcamp != null)
                    {
                        obj.SealedOrganizationId = bootcamp.SealedOrganizationId;
                    }
                    else
                    {
                        return ResultHelper.Fail("封闭机构Id获取失败");
                    }
                    List<EntityBase> entites = new List<EntityBase>();
                    if (obj.RowState == RowState.Added)
                    {
                        obj.TrySetNewEntity();
                    }
                    entites.Add(obj);
                    rsp = DbContext.GetInstance().Execute(CommandHelper.CreateSave(entites));
                    SystemHelper.CheckResponseIfError(rsp);
                    //为学员充值集训余额次数
                    SaveSealedCoachStudentMoney(obj, bootcamp);
                }
            }
            else if (studentObj.RowState == RowState.Deleted) //删除
            {
                CoachBootcampStudent coachBootcampStudent = new CoachBootcampStudent();
                //删除学员的余额信息
                coachBootcampStudent = CoachHelper.Instance.GetBootcampStudentById(studentObj.Id);
                DeleteStudentBalance(coachBootcampStudent);
                //删除学员
                SystemHelper.Instance.DeleteEntity(coachBootcampStudent);
            
            }

            return rsp;

        }

     

        public void DeleteStudentBalance(CoachBootcampStudent obj)
        {
            var sql = @"
DELETE FROM dbo.CoachStudentMoney 
WHERE 
    StudentUserId=@StudentUserId 
    AND CoachBootcampId=@CoachBootcampId
";
            var cmd = CommandHelper.CreateText<ClubUser>(FetchType.Execute, sql);
            cmd.Params.Add("@StudentUserId", obj.StudentId);
            cmd.Params.Add("@CoachBootcampId", obj.CoachBootcampId);

            var result = DbContext.GetInstance().Execute(cmd);
            SystemHelper.CheckResponseIfError(result);
        }

        /// <summary>
        /// 为学员充值集训余额次数
        /// </summary>
        /// <returns></returns>
        public void SaveSealedCoachStudentMoney(CoachBootcampStudent coachBootcampStudent, CoachBootcamp bootcamp)
        {
            Response rsp = new Response();
            CoachStudentMoney obj = new CoachStudentMoney();
            obj.StudentUserId = coachBootcampStudent.StudentId;
            obj.Amount = bootcamp.CourseCount;
            obj.ThenTotalAmount = bootcamp.CourseCount;
            obj.IsPay = true;
            obj.CourseTypeId = CoachDic.BootcampCourse;
            obj.CourseTypeName = "集训课";
            obj.CoachBootcampId = coachBootcampStudent.CoachBootcampId;
            obj.Deadline = (DateTime)bootcamp.EndTime;
            obj.RowState = RowState.Added;
            obj.TrySetNewEntity();

            List<EntityBase> entites = new List<EntityBase>();
            entites.Add(obj);
            rsp = DbContext.GetInstance().Execute(CommandHelper.CreateSave(entites));
            SystemHelper.CheckResponseIfError(rsp);
        }

        public CoachBootcampStudent GetCoachBootcampStudent(CoachBootcampStudent obj)
        {

            var sql = @"
SELECT 
   a.*,
   StudentName=dbo.fn_GetUserName(b.Id)
FROM dbo.CoachBootcampStudent a
LEFT JOIN dbo.UserAccount b ON a.StudentId=b.Id
WHERE StudentId=@StudentId 
        AND CoachBootcampId=@CoachBootcampId
";
            var cmd = CommandHelper.CreateText<CoachBootcampStudent>(FetchType.Fetch, sql);
            cmd.Params.Add("@StudentId", obj.StudentId);
            cmd.Params.Add("@CoachBootcampId", obj.CoachBootcampId);
            var result = DbContext.GetInstance().Execute(cmd);
            return result.FirstEntity<CoachBootcampStudent>();
        }

    }
}
