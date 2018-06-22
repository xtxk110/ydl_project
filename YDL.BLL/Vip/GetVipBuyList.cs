using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Core;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 获取充值购买记录列表
    /// </summary>
    public class GetVipBuyList : IService
    {
        /// <summary>
        /// 获取充值购买记录列表
        /// </summary>
        /// <param name="request">过滤器GetVipBuyListFilter</param>
        /// <returns>VipBuy</returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetVipBuyListFilter>>(request);
            var cmd = CommandHelper.CreateProcedure<VipBuy>(text: "sp_GetVipBuyList");
            cmd.Params.Add(CommandHelper.CreateParam("@userId", req.Filter.UserId.GetId()));
            cmd.Params.Add(CommandHelper.CreateParam("@userName", req.Filter.UserName));
            cmd.Params.Add(CommandHelper.CreateParam("@beginDate", req.Filter.BeginDate,DataType.Date));
            cmd.Params.Add(CommandHelper.CreateParam("@endDate", req.Filter.EndDate, DataType.Date));
            cmd.Params.Add(CommandHelper.CreateParam("@payState", req.Filter.PayState));
            cmd.Params.Add(CommandHelper.CreateParam("@pageIndex", req.Filter.PageIndex));
            cmd.Params.Add(CommandHelper.CreateParam("@pageSize", req.Filter.PageSize));
            cmd.Params.Add(CommandHelper.CreateParam("@rowCount", 0, DataType.Int32, ParamDirection.Output));
            var result = DbContext.GetInstance().Execute(cmd);
            result.RowCount = (int)result.OutParams.FirstOrDefault().value;

            return result;
        }
    }
}
