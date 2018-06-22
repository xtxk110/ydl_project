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
    /// 获取教练请假待审核数
    /// </summary>
    public class GetCoachLeaveAuditCount_187 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var sql = @"
SELECT 
	COUNT(*) AS AuditCount
FROM dbo.CoachLeave
WHERE State='010001'
";
            var cmd = CommandHelper.CreateText<CoachLeave>(FetchType.Fetch, sql);
            var result = DbContext.GetInstance().Execute(cmd);
            var obj = result.FirstEntity<CoachLeave>();
            Response response = new Response();
            response.IsSuccess = true;
            if (obj != null)
            {
                response.Tag = obj.AuditCount;
            }
            else
            {
                response.Tag = 0;
            }

            return response;

        }

    }
}
