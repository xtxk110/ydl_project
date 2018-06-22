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
    /// 获取教练--授课列表
    /// </summary>
    public class GetCoachTeachingCourseList : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetCoachRelatedFilter>>(request);
            var cmd = CommandHelper.CreateProcedure<CoachCourse>(text: "sp_GetCoachTeachingCourseList");
            cmd.Params.Add(CommandHelper.CreateParam("@CoachId", req.Filter.CoachId));
            cmd.CreateParamPager(req.Filter);

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();
            foreach (var item in result.Entities)
            {
                var obj = item as CoachCourse;
                obj.StudentList = CoachHelper.GetStudentList(obj.Id);
            }

            return result;


        }


    }
}
