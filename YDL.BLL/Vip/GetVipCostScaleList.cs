using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Core;

namespace YDL.BLL
{
    /// <summary>
    /// 获取结算比例分配列表
    /// </summary>
    public class GetVipCostScaleList : IService
    {
        /// <summary>
        /// 获取结算比例分配列表
        /// </summary>
        /// <param name="request">过滤器VipCostScale</param>
        /// <returns>VipCostScale</returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<VipCostScale>>(request);
            var cmd = CommandHelper.CreateProcedure<VipCostScale>(text: "sp_GetVipCostScaleList");
            cmd.Params.Add(CommandHelper.CreateParam("@companyId", req.Filter.CompanyId));
            cmd.Params.Add(CommandHelper.CreateParam("@costTypeId", req.Filter.CostTypeId));
            var result = DbContext.GetInstance().Execute(cmd);

            return result;
        }
    }
}
