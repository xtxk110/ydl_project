using System.Linq;
using System.Collections.Generic;

using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Core;

namespace YDL.BLL
{
    /// <summary>
    /// 获取消费记录
    /// </summary>
    public class GetVipUse : IService
    {
        /// <summary>
        /// 获取消费记录
        /// </summary>
        /// <param name="request">过滤器VipUse</param>
        /// <returns>VipUse</returns>
        public Response Execute(string request)
        {

            var req = JsonConvert.DeserializeObject<Request<VipUse>>(request);
            return VipHelper.GetVipUseInfo(req.Filter.Id, req.Filter.IsLiveUpdate);

        }

       
    }
}
