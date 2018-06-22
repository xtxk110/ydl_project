using System.Linq;
using System.Collections.Generic;

using Newtonsoft.Json;
using YDL.Utility;
using YDL.Map;
using YDL.Model;
using YDL.Core;

namespace YDL.BLL
{
    /// <summary>
    /// 获取VIP账户(done)
    /// </summary>
    public class GetVipAccount : IServiceBase
    {
        /// <summary>
        /// 获取VIP账户
        /// </summary>
        /// <param name="request">过滤器VipAccount.Id</param>
        /// <returns>VipAccount</returns>
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<VipAccount>>(request);
            return VipHelper.GetVipAccount(req.Filter.Id);
        }
    }
}
