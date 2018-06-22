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
    /// 删除课程
    /// </summary>
    public class DeleteCourse : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetCoachRelatedFilter>>(request);
            var courseId = req.Filter.CourseId;
            //获取要取消报名的学员列表
            var studentList = CoachHelper.GetStudentList(courseId);
            List<CoachCourseJoin> listNotJoin = new List<CoachCourseJoin>();
            foreach (var student in studentList)
            {
                CoachCourseJoin c = new CoachCourseJoin();
                c.CourseId = courseId;
                c.CoachId = student.CoachId;
                c.StudentId = student.UserId;
                listNotJoin.Add(c);
            }
            //取消学员课程报名
            Response result = new Response();
            if (listNotJoin.Count > 0)
            {
                result = CoachHelper.Instance.CourseNotJoin(listNotJoin);
            }
            //删除课程前先备份记录(因为这里会反算学员次数 , 备份哈记录避免后面扯皮找不到记录)
            result = BackupCourseRow(courseId);
            //删除课程
            var sql = @"DELETE CoachCourse  WHERE Id=@CourseId ";
            var cmd = CommandHelper.CreateText<ClubUser>(FetchType.Execute, sql);
            cmd.Params.Add("@CourseId", courseId);
            result = DbContext.GetInstance().Execute(cmd);
            //删除课程的说说
            result = DeleteCourseNote(courseId);
            return result;

        }

        /// <summary>
        /// 备份课程记录
        /// </summary>
        /// <param name="courseId"></param>
        /// <returns></returns>
        public Response BackupCourseRow(string courseId)
        {
            var sql = @"INSERT INTO CoachCourseBak SELECT * FROM dbo.CoachCourse WHERE Id=@CourseId ";
            var cmd = CommandHelper.CreateText<ClubUser>(FetchType.Execute, sql);
            cmd.Params.Add("@CourseId", courseId);
            return DbContext.GetInstance().Execute(cmd);
        }

        public Response DeleteCourseNote(string courseId)
        {
            var sql = @"DELETE FROM dbo.Note WHERE CourseId=@CourseId ";
            var cmd = CommandHelper.CreateText<Note>(FetchType.Execute, sql);
            cmd.Params.Add("@CourseId", courseId);
            return DbContext.GetInstance().Execute(cmd);
        }
    }
}
