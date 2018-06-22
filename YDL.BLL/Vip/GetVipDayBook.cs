using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Core;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 获取流水账列表
    /// </summary>
    public class GetVipDayBook : IService
    {
        /// <summary>
        /// 获取流水账列表
        /// </summary>
        /// <param name="request">过滤器GetVipDayBookFilter</param>
        /// <returns>VipDayBook</returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetVipDayBookFilter>>(request);
            var cmd = CommandHelper.CreateProcedure<VipDayBook>(text: "sp_GetVipDayBook");
            cmd.Params.Add(CommandHelper.CreateParam("@userId", req.Filter.UserId.GetId()));
            cmd.Params.Add(CommandHelper.CreateParam("@pageIndex", req.Filter.PageIndex));
            cmd.Params.Add(CommandHelper.CreateParam("@pageSize", req.Filter.PageSize));
            cmd.Params.Add(CommandHelper.CreateParam("@rowCount", 0, DataType.Int32, ParamDirection.Output));
            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();

            return result;
        }
    }
}
