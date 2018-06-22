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
    /// 获取支付字符串
    /// </summary>
    public class GetPayStr : IService
    {
        /// <summary>
        /// 获取支付字符串
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<PayInfo>>(request);
            var info = req.FirstEntity();

            if (info.PayOption.IsNullOrEmpty())
            {
                return ResultHelper.Fail("没有设置支付方式。");
            }

            IPay pay = CreatePay(info.PayOption);
            pay.SetPayId(info);
            if (info.AlipayId.IsNullOrEmpty())
            {
                return ResultHelper.Fail("没有设置支付宝帐号。");
            }
            var result = ResultHelper.Success();
            result.Tag = pay.GetPayString(info);

            return result;
        }

        private static IPay CreatePay(string payOption)
        {
            IPay pay = null;
            if (payOption == PayOption.ALIPAY.Id)
            {
                pay = new Alipay();
            }
            else if (payOption == PayOption.WEIXIN.Id)
            {
                pay = new WeixinPay();
            }

            return pay;
        }
    }

}
