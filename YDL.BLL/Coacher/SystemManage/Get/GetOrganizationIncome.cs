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
    /// 获取机构收入
    /// </summary>
    public class GetOrganizationIncome : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetSystemManageRelatedFilter>>(request);
            var sql = @"
   SELECT 
	SUM(a.OrganizationRealIncome)   AS TotalIncome
  FROM dbo.CoachIncome a
  INNER JOIN dbo.Coach b ON a.CoachId=b.Id
  WHERE a.CreateDate>=@BeginTime AND a.CreateDate<=@EndTime
         AND b.OrganizationId=@OrganizationId

";
            var cmd = CommandHelper.CreateText<CoachIncome>(FetchType.Fetch, sql);
            cmd.Params.Add("@BeginTime", req.Filter.CoachIncomeBeginTime);
            cmd.Params.Add("@EndTime", req.Filter.CoachIncomeEndTime.AddDays(1).AddMinutes(-1));
            cmd.Params.Add("@OrganizationId", req.Filter.OrganizationId);

            var result = DbContext.GetInstance().Execute(cmd);
            return result;

        }


    }
}
