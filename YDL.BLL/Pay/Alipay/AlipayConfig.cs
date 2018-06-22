using System.Web;
using System.Text;
using System.IO;
using System.Net;
using System;
using System.Collections.Generic;

namespace Com.Alipay
{
    /// <summary>
    /// 类名：Config
    /// 功能：基础配置类
    /// 详细：设置帐户有关信息及返回路径
    /// 版本：3.3
    /// 日期：2012-07-05
    /// 说明：
    /// 以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
    /// 该代码仅供学习和研究支付宝接口使用，只是提供一个参考。
    /// 
    /// 如何获取安全校验码和合作身份者ID
    /// 1.用您的签约支付宝账号登录支付宝网站(www.alipay.com)
    /// 2.点击“商家服务”(https://b.alipay.com/order/myOrder.htm)
    /// 3.点击“查询合作者身份(PID)”、“查询安全校验码(Key)”
    /// </summary>
    public class Config
    {
        #region 字段
        private static string partner = "";
        private static string private_key = "";
        private static string public_key = "";
        private static string input_charset = "";
        private static string sign_type = "";
        private static string alipayId = "";
        private static string appId = "";
        #endregion

        static Config()
        {
            //↓↓↓↓↓↓↓↓↓↓请在这里配置您的基本信息↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓

            //合作身份者ID，以2088开头由16位纯数字组成的字符串
            partner = "2088221871646623";

            //支付宝帐号
            alipayId = "cdydl.6-9@gotopsports.com";

            //商户的私钥
            private_key = @"MIICdQIBADANBgkqhkiG9w0BAQEFAASCAl8wggJbAgEAAoGBANuMHbcoFZXPQFcw
dDK/DSyZxj8Ukn4EcwOeibNx0HRn+gURjJNu7nyeAcocakGUY/PIjI3bCs7odaLP
Pe6FcTg+i+w1h3i+WQg2A7TsnTTNe7/b640Z3MdnWgBI/emDYAXfq9/p+eFM1t05
l67FYO8ZjHkZAV+0KP/TZTpTaCcjAgMBAAECgYBL9DifkeWN04qt31yD5ebX5Eda
sXJQ2Jc1zFZVV23Hp+UudbjNlNY7FKsH0jbMg1rlDx/ZP8uIc5GnBs2lRFM7fxNn
dC2iKmc6u/ehVp1+i0TkS5dmiuHiK/+mYitGum18uDLsuMnmye5GJYfrupPpgZc9
1LDswRKyP/HSk33A8QJBAO/wGqu3nMQcAhFJah2nso5XQgmnxdfftma0e7eNKPU/
0b4TD//17QCCgfTAiAarm0Owl8in9eL1g84uKlMgH9kCQQDqPpJev0qjylFLPLAn
QZjGWM60UDJn4zK9wsp+vxcMG6EPBv2CoNu4OanvbG0dq1tLBEwJbBVlCjZb85IO
411bAkAK7LvKJcoVg9D0SIt0XjZbFM4E8oanlaAQfRdE/EBpKka6iNOpq+DmrQqN
wlZvN1ESe+/tSvh/JP6jXKbAsi3BAkBXV++SHrgBLO51JHL2oFIMG48v0vuIm0IP
WfPRoQVCAYdjqBKdQ8fKAM5ptT9Woc+PwFFt7fxoSY+NZ9wdaxAjAkBDs9gn8Btq
4IQiWe4o6M3WB2qYSKoJIE8IgLzwq0eIBPfJLlw6Ogl72qiGL0YlgWgE+E8P4X7t
W6a2jSYOuj4q";

            //支付宝的公钥，无需修改该值
            public_key = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCnxj/9qwVfgoUh/y2W89L6BkRAFljhNhgPdyPuBV64bfQNN1PjbCzkIM6qRdKBoLPXmKKMiFYnkd6rAoprih3/PrQEB/VsW8OoM8fxn67UDYuyBTqA23MML9q1+ilIZwBC2AQ2UBVOrFXfFl75p6/B5KsiNG9zpgmLCUYuLkxpLQIDAQAB";

            //↑↑↑↑↑↑↑↑↑↑请在这里配置您的基本信息↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑



            //字符编码格式 目前支持 gbk 或 utf-8
            input_charset = "utf-8";

            //签名方式，选择项：RSA、DSA、MD5
            sign_type = "RSA";

            appId = "2016061201506839";
        }

        #region 属性
        /// <summary>
        /// 获取或设置合作者身份支付宝帐号
        /// </summary>
        public static string AlipayId
        {
            get { return alipayId; }
            set { alipayId = value; }
        }

        /// <summary>
        /// 获取或设置合作者身份ID
        /// </summary>
        public static string Partner
        {
            get { return partner; }
            set { partner = value; }
        }

        /// <summary>
        /// 获取或设置商户的私钥
        /// </summary>
        public static string Private_key
        {
            get { return private_key; }
            set { private_key = value; }
        }

        /// <summary>
        /// 获取或设置APPID
        /// </summary>
        public static string APP_ID
        {
            get { return appId; }
            set { appId = value; }
        }

        /// <summary>
        /// 获取或设置支付宝的公钥
        /// </summary>
        public static string Public_key
        {
            get { return public_key; }
            set { public_key = value; }
        }

        /// <summary>
        /// 获取字符编码格式
        /// </summary>
        public static string Input_charset
        {
            get { return input_charset; }
        }

        /// <summary>
        /// 获取签名方式
        /// </summary>
        public static string Sign_type
        {
            get { return sign_type; }
        }
        #endregion
    }
}