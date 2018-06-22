using System.Text;
using System.Collections.Generic;

using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Utility;
using YDL.Core;

namespace YDL.BLL
{
    /// <summary>
    /// 支付基类
    /// </summary>
    public interface IPay
    {
        /// <summary>
        /// 设置支付帐号
        /// </summary>
        /// <param name="info"></param>
        void SetPayId(PayInfo info);

        /// <summary>
        /// 获取支付签名字符串
        /// </summary>
        /// <param name="info"></param>
        /// <returns></returns>
        string GetPayString(PayInfo info);

        /// <summary>
        /// 获取预交易二维码
        /// </summary>
        /// <param name="info"></param>
        /// <returns></returns>
        string GetPayQrCode(PayInfo info);
    }
}
