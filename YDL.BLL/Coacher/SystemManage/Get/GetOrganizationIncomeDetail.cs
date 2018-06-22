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
    /// 获取机构收入明细
    /// </summary>
    public class GetOrganizationIncomeDetail : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetSystemManageRelatedFilter>>(request);
            var sql = @"
  SELECT 
	a.*,
    a.OrganizationRealIncome AS RealIncome,
    CourseTypeName=(CASE WHEN a.CourseType='027001' THEN '大课收入' ELSE '私教课收入' END)
  FROM dbo.CoachIncome a
  INNER JOIN dbo.Coach b ON a.CoachId=b.Id
  WHERE a.CreateDate>=@BeginTime AND a.CreateDate<=@EndTime
        AND b.OrganizationId=@OrganizationId
    ORDER BY a.CreateDate DESC
";
            var cmd = CommandHelper.CreateText<CoachIncome>(FetchType.Fetch, sql);
            cmd.Params.Add("@BeginTime", req.Filter.CoachIncomeBeginTime);
            cmd.Params.Add("@EndTime", req.Filter.CoachIncomeEndTime.AddDays(1).AddMinutes(-1));
            cmd.Params.Add("@OrganizationId", req.Filter.OrganizationId);

            var result = DbContext.GetInstance().Execute(cmd);
            var totalIncome = GetTotalIncome(req);
            var incomeArray = result.Entities.ToArray();

            //计算每条记录的总收入
            for (int i = 0; i < incomeArray.Length; i++)
            {
                var obj = incomeArray[i] as CoachIncome;

                if (i == 0)
                {
                    obj.TotalIncome = totalIncome;
                }
                else
                {
                    var previousIncomeObj = ((CoachIncome)incomeArray[i - 1]);
                    var currentTotalIncome = 0.0M;
                    if (previousIncomeObj.TotalIncome != 0)
                    {
                        currentTotalIncome = previousIncomeObj.TotalIncome - previousIncomeObj.OrganizationRealIncome;
                    }

                    obj.TotalIncome = currentTotalIncome;
                }

            }

            return result;

        }


        public decimal GetTotalIncome(Request<GetSystemManageRelatedFilter> req)
        {
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
            if (result.Entities.Count > 0)
            {
                var obj = result.Entities.First() as CoachIncome;
                return obj.TotalIncome;
            }

            return 0;
        }


    }
}
