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
    /// 获取集训课程详细列表
    /// </summary>
    public class GetCoachBootcampCourseDetailList : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetSystemManageRelatedFilter>>(request);
            var cmd = CommandHelper.CreateProcedure<CoachCourse>(text: "sp_GetCoachBootcampCourseDetailList");
            cmd.Params.Add(CommandHelper.CreateParam("@CoachBootcampCourseId",
                req.Filter.CoachBootcampCourseId));

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
