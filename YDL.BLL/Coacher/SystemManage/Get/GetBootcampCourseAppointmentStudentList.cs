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
    /// 获取集训课程的预约学员列表
    /// </summary>
    public class GetBootcampCourseAppointmentStudentList : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetSystemManageRelatedFilter>>(request);
            var cmd = CommandHelper.CreateProcedure<User>(text: "sp_GetBootcampCourseAppointmentStudentList");
            cmd.Params.Add(CommandHelper.CreateParam("@BootcampCourseId", req.Filter.CoachBootcampCourseId));
            cmd.CreateParamPager(req.Filter);

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();

            return result;
 

        }


    }
}
