using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using qcloudsms_csharp.httpclient;
using qcloudsms_csharp;

namespace SMSTest
{
    class Program
    {// 短信应用SDK AppID
        private static int appid = 1400036991;
        // 短信应用SDK AppKey
        private static string appkey = "db5952174f54c76c18c368a21779c11b";
        //发送验证码的短信模板ID
        private static int valCodeTemplateId = 71158;
        static void Main(string[] args)
        {
            SmsSingleSender singleSender = new SmsSingleSender(appid,appkey);
            SmsSingleSenderResult resutl = singleSender.send(0, "86", "18328636270", "这是测试信息", "", "");
            Console.WriteLine(resutl.result+"---"+resutl.errMsg);
            Console.ReadKey();
        }
    }
}
