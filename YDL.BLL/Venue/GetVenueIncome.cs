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
    /// 获取场馆收入
    /// </summary>
    public class GetVenueIncome : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetVenueRelatedFilter>>(request);
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
            return result;

        }


    }
}
