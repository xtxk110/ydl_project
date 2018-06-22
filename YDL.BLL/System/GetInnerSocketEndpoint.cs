using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;

namespace YDL.BLL
{
    /// <summary>
    /// 获取局域网socket 服务器ip和端口
    /// </summary>
    class GetInnerSocketEndpoint:IService
    {
        public Response Execute(string request)
        {
            Response response = ResultHelper.CreateResponse();
            response.Tag = UserHelper.GetConfig().IntranetSocketIpAndPort;//局域网SOCKET地址
            return response;
        }
    }
}
