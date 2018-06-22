using System;
using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Core;
using YDL.Utility;

namespace YDL.BLL
{
    public class GetTVInfoList : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetCoachRelatedFilter>>(request);
            var sql = @"
SELECT * FROM dbo.SysDic WHERE Type='电视' ORDER BY SortIndex  ASC
";
            var cmd = CommandHelper.CreateText<TVInfo>(FetchType.Fetch, sql);
            var result = DbContext.GetInstance().Execute(cmd);
            return result;

        }


    }
}
