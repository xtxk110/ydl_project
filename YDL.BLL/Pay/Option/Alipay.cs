using System.Collections.Generic;
using System.Text;
using System.Web;

using Aop.Api;
using Aop.Api.Request;
using Aop.Api.Response;
using YDL.Map;
using YDL.Model;

namespace YDL.BLL
{
    /// <summary>
    /// 支付宝支付
    /// </summary>
    public class Alipay : IPay
    {
        private static readonly string ALIPAY_NOTIFY_URL = "\"https://www.gotopsports.com/service/NotifyAlipay.aspx\"";

        /// <summary>
        /// 设置支付宝帐号
        /// </summary>
        /// <param name="info"></param>
        public void SetPayId(PayInfo info)
        {
            string type = info.BillId.Substring(0, 2);

            if (type == BillType.VIP_VENUE_BILL)//支付结算单，查找场馆支付宝帐号
            {
                info.AlipayId = GetPayId("SELECT AlipayId FROM VenueBill a JOIN Venue b ON b.Id=a.VenueId WHERE a.OrderNo=@orderNo", info.BillId);
            }
            else if (type == BillType.VIP_REFUND)//退款单，查找退款单支付宝帐号
            {
                info.AlipayId = GetPayId("SELECT AlipayId FROM VipRefund WHERE OrderNo=@orderNo", info.BillId);
            }
            else//本公司支付宝帐号
            {
                info.AlipayId = Com.Alipay.Config.AlipayId;
            }
        }

        /// <summary>
        /// 获取预交易二维码
        /// </summary>
        /// <param name="info"></param>
        public string GetPayQrCode(PayInfo info)
        {
            IAopClient client = new DefaultAopClient("https://openapi.alipay.com/gateway.do", Com.Alipay.Config.APP_ID, Com.Alipay.Config.Private_key);

            AlipayAcquirePrecreateRequest request = new AlipayAcquirePrecreateRequest();
            request.SellerId = info.AlipayId;
            request.SetNotifyUrl("https://www.gotopsports.com/service/NotifyAlipay.aspx");
            request.OutTradeNo = info.BillId;

            string subject;
            string body;
            PayHelper.GetSubjectAndBody(info, out subject, out body);

            request.Subject = subject;
            request.Body = body;
            request.TotalFee = info.PayAmount.ToString();

            request.ItBPay = "1d";
            var response = client.Execute<AlipayAcquirePrecreateResponse>(request);
            //调用成功，则处理业务逻辑
            if (response.IsSuccess == "T")
            {
                return response.QrCode;
            }

            return null;

        }

        private string GetPayId(string sql, string orderNo)
        {
            var cmd = CommandHelper.CreateText(FetchType.Scalar);
            cmd.Text = sql;
            cmd.Params.Add("@orderNo", orderNo);
            var temp = DbContext.GetInstance().Execute(cmd);

            return temp.Tag as string;
        }

        /// <summary>
        /// 获取支付宝签名字符串
        /// </summary>
        /// <param name="info"></param>
        /// <returns></returns>
        public string GetPayString(PayInfo info)
        {
            var orderInfo = GetOrderInfo(info);

            //订单RSA签名
            var sign = Com.Alipay.RSAFromPkcs8.sign(orderInfo, Com.Alipay.Config.Private_key, Com.Alipay.Config.Input_charset);

            //仅对SIGN作URL编码
            sign = HttpUtility.UrlEncode(sign, Encoding.UTF8);

            string payInfo = orderInfo + "&sign=\"" + sign + "\"&" + GetSignType();

            return payInfo;
        }

        private string GetSignType()
        {
            return "sign_type=\"RSA\"";
        }

        private string GetOrderInfo(PayInfo info)
        {
            string subject;                                                                                                                                                                                              
            string body;
            PayHelper.GetSubjectAndBody(info, out subject, out body);

            Dictionary<string, string> payinfo = new Dictionary<string, string>();
            payinfo.Add("partner", "\"" + Com.Alipay.Config.Partner + "\"");
            payinfo.Add("seller_id", "\"" + info.AlipayId + "\"");
            payinfo.Add("out_trade_no", "\"" + info.BillId + "\"");
            payinfo.Add("subject", "\"" + subject + "\"");
            payinfo.Add("body", "\"" + body + "\"");
            payinfo.Add("total_fee", "\"" + info.PayAmount + "\"");
            payinfo.Add("service", "\"mobile.securitypay.pay\"");
            payinfo.Add("notify_url", ALIPAY_NOTIFY_URL);
            payinfo.Add("payment_type", "\"1\"");
            payinfo.Add("_input_charset", "\"UTF-8\"");
            payinfo.Add("it_b_pay", "\"30m\"");

            return Com.Alipay.Core.CreateLinkString(payinfo);
        }

    }
}
