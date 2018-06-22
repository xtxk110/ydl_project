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
    /// 学员获取预约体验课状态
    /// </summary>
    public class GetOrderTrialCourseState : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetCoachRelatedFilter>>(request);

            Response rsp = new Response();
            string sql = @"
SELECT * FROM dbo.CoachOrderTrialCourse WHERE StudentId=@StudentId
";
            var cmd = CommandHelper.CreateText<CoachOrderTrialCourse>(FetchType.Fetch, sql);
            cmd.Params.Add("@StudentId", req.Filter.StudentId);
            var result = DbContext.GetInstance().Execute(cmd);
            if (result.Entities.Count > 0)
            {
                rsp.Tag = true;
            }
            else
            {
                rsp.Tag = false;
            }

            rsp.IsSuccess = true;

            return rsp;
        }


    }
}
