using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Map;
using YDL.Model;
using WxPayAPI;
using Newtonsoft.Json;

namespace YDL.BLL
{
    /// <summary>
    /// 微信支付
    /// </summary>
    public class WeixinPay : IPay
    {
        /// <summary>
        /// 设置支付帐号
        /// </summary>
        /// <param name="info"></param>
        public void SetPayId(PayInfo info)
        {
            info.AlipayId = WxPayAPI.WxPayConfig.MCHID;
        }

        /// <summary>
        /// 获取支付签名字符串
        /// </summary>
        /// <param name="info"></param>
        /// <returns></returns>
        public string GetPayString(PayInfo info)
        {
            return GetUnifiedOrderResult(info);
        }

        /**
         * 调用统一下单，获得下单结果
         * @return 统一下单结果
         * @失败时抛异常WxPayException
         */
        private string GetUnifiedOrderResult(PayInfo info)
        {
            string subject;
            string body;
            PayHelper.GetSubjectAndBody(info, out subject, out body);

            //统一下单
            WxPayData data = new WxPayData();
            data.SetValue("body", subject);
            data.SetValue("out_trade_no", info.BillId);
            //金额单位分
            data.SetValue("total_fee", (int)info.PayAmount*100);
            data.SetValue("time_start", DateTime.Now.ToString("yyyyMMddHHmmss"));
            data.SetValue("time_expire", DateTime.Now.AddMinutes(10).ToString("yyyyMMddHHmmss"));
            data.SetValue("trade_type", "APP");

            WxPayData result = WxPayApi.UnifiedOrder(data);
            if (!result.IsSet("appid") || !result.IsSet("prepay_id") || result.GetValue("prepay_id").ToString() == "")
            {
                throw new WxPayException("UnifiedOrder response error!");
            }

            //客户端调起支付接口需要参数
            WeixinPayReq req = new WeixinPayReq();
            req.Appid = result.GetValue("appid").ToString();
            req.Partnerid = result.GetValue("mch_id").ToString();
            req.Prepayid = result.GetValue("prepay_id").ToString();
            req.Noncestr = WxPayAPI.WxPayApi.GenerateNonceStr();
            req.Timestamp = WxPayAPI.WxPayApi.GenerateTimeStamp();
            req.Sign = MakeSecondSign(req);

            return JsonConvert.SerializeObject(req);
        }

        private string MakeSecondSign(WeixinPayReq req) {
            WxPayData data = new WxPayData();
            data.SetValue("appid", req.Appid);
            data.SetValue("partnerid", req.Partnerid);
            data.SetValue("prepayid", req.Prepayid);
            data.SetValue("package", req.Package);
            data.SetValue("noncestr", req.Noncestr);
            data.SetValue("timestamp", req.Timestamp);
            return data.MakeSign();
        }

        /// <summary>
        /// 获取预交易二维码
        /// </summary>
        /// <param name="info"></param>
        /// <returns></returns>
        public string GetPayQrCode(PayInfo info)
        {
            return null;
        }
    }
}
