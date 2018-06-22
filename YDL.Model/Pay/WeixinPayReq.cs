using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Core;
using YDL.Utility;

namespace YDL.Model
{
    /// <summary>
    /// 微信请求支付类
    /// </summary>
    public class WeixinPayReq : EntityBase
    {
        /// <summary>
        /// 应用APPID
        /// </summary>
        public String Appid { get; set; }

        /// <summary>
        /// 商户号
        /// </summary>
        public String Partnerid { get; set; }

        /// <summary>
        /// 支付交易会话ID
        /// </summary>
        public String Prepayid { get; set; }

        /// <summary>
        /// Package固定值Sign=WXPay
        /// </summary>
        public String Package { get { return "Sign=WXPay"; } }

        /// <summary>
        /// 随机字符串
        /// </summary>
        public String Noncestr { get; set; }

        /// <summary>
        /// 时间戳
        /// </summary>
        public String Timestamp { get; set; }

        /// <summary>
        /// 签名
        /// </summary>
        public String Sign { get; set; }
    }
}
