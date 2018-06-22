using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Core;

namespace YDL.BLL
{
    /// <summary>
    /// 获取充值配送比率列表
    /// </summary>
    public class GetVipRechargeScaleList : IService
    {
        /// <summary>
        /// 获取充值配送比率列表
        /// </summary>
        /// <param name="request">过滤器VipRechargeScale</param>
        /// <returns>VipRechargeScale</returns>
        public Response Execute(string request)
        {
            
            return VipHelper.GetVipRechargeScaleList();
        }
    }
}
