using System;
using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Core;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 获取学员--上课列表
    /// </summary>
    public class GetStudentJoinCourseList : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetCoachRelatedFilter>>(request);
            var cmd = CommandHelper.CreateProcedure<CoachCourse>(text: "GetStudentJoinCourseList");
            cmd.Params.Add("@StudentId", req.Filter.StudentId);
            cmd.CreateParamPager(req.Filter);

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();
            foreach (var item in result.Entities)
            {
                var obj = item as CoachCourse;
                obj.StudentList = CoachHelper.GetStudentList(obj.CourseId);
            }
            result.Tag = IsExistTrialCourse(req.Filter.StudentId);
            return result;


        }

        public bool IsExistTrialCourse(string StudentId)
        {
            string sql = @"
SELECT Id FROM dbo.CoachOrderTrialCourse WHERE StudentId=@StudentId
";
            var cmd = CommandHelper.CreateText<CoachOrderTrialCourse>(FetchType.Fetch, sql);
            cmd.Params.Add("@StudentId", StudentId);
            var result = DbContext.GetInstance().Execute(cmd);
            if (result.Entities.Count > 0)
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
