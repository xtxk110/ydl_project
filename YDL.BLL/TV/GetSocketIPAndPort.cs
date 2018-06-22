using System;
using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Core;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 获取socket 服务器ip和端口
    /// </summary>
    public class GetSocketIPAndPort_191 
    {
        public static Response Execute(string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetCoachRelatedFilter>>(request);
            Response rsp = ResultHelper.CreateResponse();
            rsp.Tag = UserHelper.GetConfig().IntranetSocketIpAndPort;
            return rsp;

        }


    }
}
