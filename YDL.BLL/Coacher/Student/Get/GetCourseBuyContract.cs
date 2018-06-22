using System;
using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Core;
using YDL.Utility;
using System.Collections.Generic;

namespace YDL.BLL
{
    /// <summary>
    /// 获取购买协议
    /// </summary>
    public class GetCourseBuyContract_186 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetCoachRelatedFilter>>(request);
            string detail = "123";
            Response rsp = new Response();
            rsp.IsSuccess = true;
            rsp.Tag = detail;
            return rsp;
        }
        
    }

}
