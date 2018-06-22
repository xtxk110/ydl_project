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
    /// 获取课程详情--学员列表
    /// </summary>
    public class GetCourseStudentList : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetCoachRelatedFilter>>(request);
            var studentList = CoachHelper.GetStudentList(req.Filter.CourseId);
            Response rsp = new Response();
            rsp.IsSuccess = true;
            if (studentList.Count > 0)
            {
                rsp.Entities = studentList.ToList<CoachStudent, EntityBase>();
            }
            return rsp;
        }


    }
}
