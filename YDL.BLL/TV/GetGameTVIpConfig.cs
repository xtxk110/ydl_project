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
    /// 获取赛事tv IP配置
    /// </summary>
    public class GetGameTVIpConfig_191 
    {
        public static Response Execute(string request)
        {

            Response rsp = ResultHelper.CreateResponse();
            rsp.Tag = "http://" + UserHelper.GetConfig().IntranetHttpIpAndPort;
            rsp.Tag1 = UserHelper.GetConfig().IntranetSocketIpAndPort;
            return rsp;

        }


    }
}
