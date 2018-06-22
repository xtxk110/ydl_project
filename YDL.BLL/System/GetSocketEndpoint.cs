using System;
using YDL.Map;
using YDL.Model;

namespace YDL.BLL
{
    /// <summary>
    /// 获取云SOCKET服务器地址：XX.XX.XX.XX:XX
    /// </summary>
    public class GetSocketEndpoint: IService
    {
        public Response Execute(string request)
        {
            Response response= ResultHelper.CreateResponse();
            response.Tag = UserHelper.GetConfig().SocketIpAndPort;//云SOCKET地址，目前只供直播比分显示使用
            return response;
        }

    }
}
