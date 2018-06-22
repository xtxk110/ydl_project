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
    /// 删除集训课的详情
    /// </summary>
    public class DeleteCoachBootcampCourseDetail : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<CoachCourse>>(request);
            var obj = req.FirstEntity();

            var sql = @"
DELETE FROM dbo.CoachCourse WHERE Id=@Id;
DELETE FROM dbo.CoachCourseJoin WHERE CourseId=@Id;
";
            var cmd = CommandHelper.CreateText<CoachCourse>(FetchType.Execute, sql);
            cmd.Params.Add("@Id", obj.Id);

            var result = DbContext.GetInstance().Execute(cmd);
            return result;

        }


    }
}
