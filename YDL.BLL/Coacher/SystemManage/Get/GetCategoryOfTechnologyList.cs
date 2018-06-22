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
    /// 获取技术类别列表
    /// </summary>
    public class GetCategoryOfTechnologyList : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetSystemManageRelatedFilter>>(request);

            var sql = @"
SELECT * FROM dbo.SysDic 
WHERE Type='CategoryOfTechnology'
";
            if (!string.IsNullOrEmpty(req.Filter.TeachTypeName))
            {
                sql += " AND Name LIKE '%"+ req.Filter.TeachTypeName + "%'";
            }
            var cmd = CommandHelper.CreateText<SysDic>(FetchType.Fetch, sql);
            var result = DbContext.GetInstance().Execute(cmd);

            return result;

        }


    }
}
