using System.Linq;
using System.Collections.Generic;

using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Core;

namespace YDL.BLL
{
    /// <summary>
    /// 获取充值购买记录
    /// </summary>
    public class GetVipBuy : IService
    {
        /// <summary>
        /// 获取充值购买记录
        /// </summary>
        /// <param name="request">过滤器VipBuy</param>
        /// <returns>VipBuy</returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<VipBuy>>(request);
            var obj = VipHelper.GetVipBuy(req.Filter.Id);
            if (obj == null)
            {
                return ResultHelper.Fail("记录不存在。可能已被删除。");
            }
            return ResultHelper.Success(new List<EntityBase> { obj });
        }
    }
}
