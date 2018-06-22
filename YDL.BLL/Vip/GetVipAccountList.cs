using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Core;

namespace YDL.BLL
{
    /// <summary>
    /// 获取VIP账户列表
    /// </summary>
    public class GetVipAccountList : IService
    {
        /// <summary>
        /// 获取VIP账户列表
        /// </summary>
        /// <param name="request">过滤器GetVipAccountListFilter</param>
        /// <returns>VipAccount</returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetVipAccountListFilter>>(request);
            var cmd = CommandHelper.CreateProcedure<VipAccount>(text: "sp_GetVipAccountList");
            cmd.Params.Add(CommandHelper.CreateParam("@userName", req.Filter.UserName));
            cmd.Params.Add(CommandHelper.CreateParam("@pageIndex", req.Filter.PageIndex));
            cmd.Params.Add(CommandHelper.CreateParam("@pageSize", req.Filter.PageSize));
            cmd.Params.Add(CommandHelper.CreateParam("@rowCount", 0, DataType.Int32, ParamDirection.Output));
            var result = DbContext.GetInstance().Execute(cmd);
            result.RowCount = (int)result.OutParams.FirstOrDefault().value;

            return result;
        }
    }
}
