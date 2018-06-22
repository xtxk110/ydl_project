using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Utility;
using YDL.Core;

namespace YDL.BLL
{
    /// <summary>
    /// 获取退款单列表
    /// </summary>
    public class GetVipRefundList : IService
    {
        /// <summary>
        /// 获取退款单列表
        /// </summary>
        /// <param name="request">过滤器GetVipRefoundListFilter</param>
        /// <returns>VipRefound</returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetVipRefundListFilter>>(request);
            var cmd = CommandHelper.CreateProcedure<VipRefund>(FetchType.Fetch, "sp_GetVipRefundList");
            cmd.Params.Add(CommandHelper.CreateParam("@userId", req.Filter.UserId));
            //客户端传过来日期格式的字符串
            cmd.Params.Add(CommandHelper.CreateParam("@beginDate", req.Filter.BeginDate));
            cmd.Params.Add(CommandHelper.CreateParam("@endDate", req.Filter.EndDate));
            cmd.CreateParamPager(req.Filter);

            var result = DbContext.GetInstance().Execute(cmd);
            result.RowCount = (int)result.OutParams.FirstOrDefault().value;

            return result;
        }
    }
}
