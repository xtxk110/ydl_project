using System.Web.Services;
using Newtonsoft.Json;
using System;
using YDL.BLL;
using YDL.Map;
using YDL.Utility;

namespace YDL.Web.Service
{
    /// <summary>
    /// DataService供移动客户端调用
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消注释以下行。 
    // [System.Web.Script.Services.ScriptService]
    public class DataService : System.Web.Services.WebService
    {
        [WebMethod(EnableSession = true)]
        public string ExcuteBll(string serviceName, string request)
        {

            var aes = AESOperator.GetInstance();

            var service = aes.Decrypt(serviceName);
            var req = aes.Decrypt(request);
            var result = ServiceBuilder.GetInstance().Execute(service, req,Formatting.None);

            var cmd = JsonConvert.DeserializeObject<Request>(req);
            return cmd.IsEncrypt ? aes.Encrypt(result) : result;
        }
    }
}
