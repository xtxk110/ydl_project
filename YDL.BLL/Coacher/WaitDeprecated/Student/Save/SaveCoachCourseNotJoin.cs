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
    /// 课程取消报名
    /// </summary>
    public class SaveCoachCourseNotJoin : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<CoachCourseJoin>>(request);
            Response result = new Response();
            result = CoachHelper.Instance.CourseNotJoin(req.Entities);
            return result;

        }

    }
}
