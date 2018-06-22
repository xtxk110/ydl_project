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
    /// 获取常用学员列表
    /// </summary>
    public class GetFrequentStudentList_186 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetCoachRelatedFilter>>(request);
            var sql = @"
SELECT * FROM CoachFrequentStudent WHERE CreatorId=@CreatorId
";
            var cmd = CommandHelper.CreateText<CoachFrequentStudent>(FetchType.Fetch, sql);
            cmd.Params.Add("@CreatorId", req.Filter.CurrentUserId);
            var result = DbContext.GetInstance().Execute(cmd);
            return result;
        }


    }
}
