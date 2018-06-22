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
    /// 是否为教学点课程管理员
    /// </summary>
    public class IsTeachingPointManager : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetCoachRelatedFilter>>(request);
            string sql = @"
SELECT Id FROM dbo.Venue WHERE Id=@VenueId AND CourseManagerId=@CurrentUserId
";
            var cmd = CommandHelper.CreateText<Venue>(FetchType.Fetch, sql);
            cmd.Params.Add("@VenueId", req.Filter.VenueId);
            cmd.Params.Add("@CurrentUserId", req.Filter.CurrentUserId);

            var result = DbContext.GetInstance().Execute(cmd);
             
            if (result.Entities.Count > 0)
            {
                result.Tag = true;
                return result;
            }
            else
            {
                result.Tag = false;
                return result;
            }

        }

    }
}
