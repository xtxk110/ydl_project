using System;
using System.Security.Cryptography;
using System.Text;
using System.Threading;
using System.Configuration;

using YDL.Map;
using YDL.Model;
using Newtonsoft.Json;

namespace YDL.BLL
{
    /// <summary>
    /// 获取上传视频的签名
    /// </summary>
    public class GetVideoSignature : IService
    {
        //腾讯云API密钥 AppID
        private static string APISecretId = ConfigurationManager.AppSettings["APISecretId"];
        //AppKey
        private static string APISecretKey = ConfigurationManager.AppSettings["APISecretKey"];

        public Response Execute(string request)
        {
            Signature sign = new Signature();
            sign.m_strSecId = APISecretId;
            sign.m_strSecKey = APISecretKey;
            sign.m_qwNowTime = Signature.GetIntTimeStamp();
            sign.m_iRandom = new Random().Next(0, 1000000);
            sign.m_iSignValidDuration = 3600 * 24 * 2;

            var result = ResultHelper.Success();
            result.Tag = sign.GetUploadSignature();
            return result;
        }
    }

    public class Signature
    {
        public string m_strSecId;
        public string m_strSecKey;
        public int m_iRandom;
        public long m_qwNowTime;
        public int m_iSignValidDuration;
        public static long GetIntTimeStamp()
        {
            TimeSpan ts = DateTime.UtcNow - new DateTime(1970, 1, 1);
            return Convert.ToInt64(ts.TotalSeconds);
        }
        private byte[] hash_hmac_byte(string signatureString, string secretKey)
        {
            var enc = Encoding.UTF8; HMACSHA1 hmac = new HMACSHA1(enc.GetBytes(secretKey));
            hmac.Initialize();
            byte[] buffer = enc.GetBytes(signatureString);
            return hmac.ComputeHash(buffer);
        }
        public string GetUploadSignature()
        {
            string strContent = "";
            strContent += ("secretId=" + Uri.EscapeDataString((m_strSecId)));
            strContent += ("&currentTimeStamp=" + m_qwNowTime);
            strContent += ("&expireTime=" + (m_qwNowTime + m_iSignValidDuration));
            strContent += ("&random=" + m_iRandom);

            byte[] bytesSign = hash_hmac_byte(strContent, m_strSecKey);
            byte[] byteContent = System.Text.Encoding.Default.GetBytes(strContent);
            byte[] nCon = new byte[bytesSign.Length + byteContent.Length];
            bytesSign.CopyTo(nCon, 0);
            byteContent.CopyTo(nCon, bytesSign.Length);
            return Convert.ToBase64String(nCon);
        }
    }
}
