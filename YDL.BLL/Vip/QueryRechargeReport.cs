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
    /// 查询充值报表
    /// </summary>
    public class QueryRechargeReport : IService
    {
        /// <summary>
        /// 查询充值报表
        /// </summary>
        /// <param name="request">过滤器QueryRechargeReportFilter</param>
        /// <returns>返回RechargeReport</returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<QueryRechargeReportFilter>>(request);
            var cmd = CommandHelper.CreateProcedure<RechargeReport>(text: "sp_QueryRechargeReport");
            cmd.Params.Add(CommandHelper.CreateParam("@year", req.Filter.Year, DataType.Int32));
            cmd.Params.Add(CommandHelper.CreateParam("@beginMonth", req.Filter.BeginMonth, DataType.Int32));
            cmd.Params.Add(CommandHelper.CreateParam("@endMonth", req.Filter.EndMonth, DataType.Int32));

            var result = DbContext.GetInstance().Execute(cmd);
            return result;
        }
    }
}
