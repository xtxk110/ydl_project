using System.Linq;
using System;
using Newtonsoft.Json;
using YDL.Utility;
using YDL.Map;
using YDL.Model;
using YDL.Core;

namespace YDL.BLL
{
    /// <summary>
    /// 查询收入报表
    /// </summary>
    public class QueryBillReport : IService
    {
        /// <summary>
        /// 查询收入报表
        /// </summary>
        /// <param name="request">过滤器QueryBillReportFilter</param>
        /// <returns>BillReport</returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<QueryBillReportFilter>>(request);
            var cmd = CommandHelper.CreateProcedure<BillReport>(text: "sp_QueryBillReport");
            cmd.Params.Add(CommandHelper.CreateParam("@isPayDate", req.Filter.IsPayDate, DataType.Boolean));
            cmd.Params.Add(CommandHelper.CreateParam("@hasNoPay", req.Filter.HasNoPay, DataType.Boolean));
            cmd.Params.Add(CommandHelper.CreateParam("@beginDate", req.Filter.BeginDate, DataType.Date));
            cmd.Params.Add(CommandHelper.CreateParam("@endDate", req.Filter.EndDate, DataType.Date));
            cmd.Params.Add(CommandHelper.CreateParam("@companyId", req.Filter.CompanyId));
            cmd.Params.Add(CommandHelper.CreateParam("@venueId", req.Filter.VenueId));
            var result = DbContext.GetInstance().Execute(cmd);

            return result;
        }
    }
}
