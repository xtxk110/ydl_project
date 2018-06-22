using System.Text;
using System.Collections.Generic;

using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Utility;
using YDL.Core;

namespace YDL.BLL
{
    /// <summary>
    /// 获取笔记举报类型
    /// </summary>
    public class GetNoteWhistleBlowingType : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var sql = @"
SELECT 
    Code,
    Name 
FROM dbo.SysDic 
WHERE Type='举报'
ORDER BY SortIndex

";
            var cmd = CommandHelper.CreateText<SysDic>(FetchType.Fetch, sql);

            var result = DbContext.GetInstance().Execute(cmd);
            return result;
        }
    }

}
