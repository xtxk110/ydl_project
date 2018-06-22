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
    /// 获取教练请假详情
    /// </summary>
    public class GetCoachLeaveDetail_187 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetCoachRelatedFilter>>(request);
            string sql = @"
SELECT 
	a.*,
	b.Name AS LeaveTypeName
FROM dbo.CoachLeave a
LEFT JOIN dbo.SysDic b ON a.LeaveType=b.Code
WHERE a.Id=@Id 
               
";

            var cmd = CommandHelper.CreateText<CoachLeave>(FetchType.Fetch, sql);
            cmd.Params.Add("@Id", req.Filter.CoachLeaveId);
            var result = DbContext.GetInstance().Execute(cmd);
            var obj = result.FirstEntity<CoachLeave>();
            if (obj != null)
            {
                obj.TryGetFiles();
            }
            return result;
        }



    }


}
