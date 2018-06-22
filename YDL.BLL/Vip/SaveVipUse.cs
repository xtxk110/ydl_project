using System;
using System.Linq;
using System.Collections.Generic;

using Newtonsoft.Json;
using YDL.Core;
using YDL.Map;
using YDL.Model;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 保存消费记录
    /// </summary>
    public class SaveVipUse : IService
    {
        /// <summary>
        /// 保存消费记录
        /// </summary>
        /// <param name="request">实体VipUse</param>
        /// <returns></returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<VipUse>>(request);

            var result = ResultHelper.Success();
            result.Tag = VipHelper.SaveVipUse(req.Entities.FirstOrDefault()); ;//返回主键，供下一步使用。

            return result;
        }

    }

}
