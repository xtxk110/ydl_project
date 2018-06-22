using System.Linq;
using Newtonsoft.Json;
using YDL.Utility;
using YDL.Map;
using YDL.Model;
using YDL.Core;

namespace YDL.BLL
{
    /// <summary>
    /// 获取消费列表
    /// </summary>
    public class GetVipUseList : IService
    {
        /// <summary>
        /// 获取消费列表
        /// </summary>
        /// <param name="request">过滤器GetVipUseListFilter</param>
        /// <returns>VipUse</returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetVipUseListFilter>>(request);
            var cmd = CommandHelper.CreateProcedure<VipUse>(text: "sp_GetVipUseList");
            cmd.Params.Add(CommandHelper.CreateParam("@venueId", req.Filter.VenueId.GetId()));
            cmd.Params.Add(CommandHelper.CreateParam("@userId", req.Filter.UserId.GetId()));
            cmd.Params.Add(CommandHelper.CreateParam("@userName", req.Filter.UserName));
            cmd.Params.Add(CommandHelper.CreateParam("@beginDate", req.Filter.BeginDate, DataType.Date));
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
