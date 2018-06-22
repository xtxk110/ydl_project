using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Core;

namespace YDL.BLL
{
    /// <summary>
    /// 获取退款单
    /// </summary>
    public class GetVipRefund : IService
    {
        /// <summary>
        /// 获取退款单
        /// </summary>
        /// <param name="request">过滤器VipRefund</param>
        /// <returns>VipRefund</returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<VipRefund>>(request);
            var cmd = CommandHelper.CreateProcedure<VipRefund>(text: "sp_GetVipRefund");
            cmd.Params.Add(CommandHelper.CreateParam("@id", req.Filter.Id));
            var result = DbContext.GetInstance().Execute(cmd);

            return result;
        }
    }
}
