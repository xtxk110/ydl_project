using System.Collections.Generic;

using YDL.Core;
using YDL.Map;
using YDL.Model;
using Newtonsoft.Json;

namespace YDL.BLL
{
    /// <summary>
    /// 获取接口IP（区分正式版，和提交商城审核的版本）
    /// </summary>
    public class GetInterfaceIp : IService
    {
        /// <summary>
        /// 获取接口IP
        /// </summary>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<RequestAppStore>>(request);
            var temp = req.Filter;

            if (Globals.IsRequestAppStoreVer(temp.Version))
                temp.Ip = Globals.RequestAppStoreIP();

            Response result = ResultHelper.Success(new List<EntityBase> { temp });

            return result;
        }
    }
}
