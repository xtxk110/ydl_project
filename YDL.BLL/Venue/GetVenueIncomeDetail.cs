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
    /// 获取场馆收入明细
    /// </summary>
    public class GetVenueIncomeDetail : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetVenueRelatedFilter>>(request);
            var sql = @"
  SELECT 
	a.CreateDate,
    a.Amount AS RealIncome,
	CourseTypeName=(dbo.fn_GetUserName(b.Id)+' 转入')
  FROM dbo.VipUse a
  LEFT JOIN dbo.UserAccount b ON a.CreatorId=b.Id
  WHERE a.CreateDate>=@BeginTime AND a.CreateDate<=@EndTime
        AND a.VenueId=@VenueId
    ORDER BY a.CreateDate DESC
";
            var cmd = CommandHelper.CreateText<VenueIncome>(FetchType.Fetch, sql);
            cmd.Params.Add("@BeginTime", req.Filter.IncomeBeginTime);
            cmd.Params.Add("@EndTime", req.Filter.IncomeEndTime.AddDays(1).AddMinutes(-1));
            cmd.Params.Add("@VenueId", req.Filter.VenueId);

            var result = DbContext.GetInstance().Execute(cmd);
            var totalIncome = GetTotalIncome(req);
            var incomeArray = result.Entities.ToArray();

            //计算每条记录的总收入
            for (int i = 0; i < incomeArray.Length; i++)
            {
                var obj = incomeArray[i] as VenueIncome;

                if (i == 0)
                {
                    obj.TotalIncome = totalIncome;
                }
                else
                {
                    var previousIncomeObj = ((VenueIncome)incomeArray[i - 1]);
                    decimal currentTotalIncome = 0;
                    if (previousIncomeObj.TotalIncome != 0)
                    {
                        currentTotalIncome = previousIncomeObj.TotalIncome - previousIncomeObj.RealIncome;

                    }
                    obj.TotalIncome = currentTotalIncome;
                }

            }

            return result;

        }


        public decimal GetTotalIncome(Request<GetVenueRelatedFilter> req)
        {
            var sql = @"
  SELECT 
	SUM(Amount)   AS TotalIncome
  FROM dbo.VipUse
  WHERE CreateDate>=@BeginTime AND CreateDate<=@EndTime
        AND VenueId=@VenueId

";
            var cmd = CommandHelper.CreateText<VenueIncome>(FetchType.Fetch, sql);
            cmd.Params.Add("@BeginTime", req.Filter.IncomeBeginTime);
            cmd.Params.Add("@EndTime", req.Filter.IncomeEndTime.AddDays(1).AddMinutes(-1));
            cmd.Params.Add("@VenueId", req.Filter.VenueId);

            var result = DbContext.GetInstance().Execute(cmd);
            if (result.Entities.Count > 0)
            {
                var obj = result.Entities.First() as VenueIncome;
                return obj.TotalIncome;
            }

            return 0;
        }


    }
}
