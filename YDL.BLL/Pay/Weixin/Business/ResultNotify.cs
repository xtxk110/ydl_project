using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using YDL.BLL;
using YDL.Model;

namespace WxPayAPI
{
    /// <summary>
    /// 支付结果通知回调处理类
    /// 负责接收微信支付后台发送的支付结果并对订单有效性进行验证，将验证结果反馈给微信支付后台
    /// </summary>
    public class ResultNotify : Notify
    {
        public ResultNotify(Page page)
            : base(page)
        {
        }

        public override void ProcessNotify()
        {
            WxPayData notifyData = GetNotifyData();

            //检查支付结果中transaction_id是否存在
            if (!notifyData.IsSet("transaction_id"))
            {
                //若transaction_id不存在，则立即返回结果给微信支付后台
                WxPayData res = new WxPayData();
                res.SetValue("return_code", "FAIL");
                res.SetValue("return_msg", "支付结果中微信订单号不存在");
                page.Response.Write(res.ToXml());
                page.Response.End();
            }

            string transaction_id = notifyData.GetValue("transaction_id").ToString();

            //查询订单，判断订单真实性
            if (!QueryOrder(transaction_id))
            {
                //若订单查询失败，则立即返回结果给微信支付后台
                WxPayData res = new WxPayData();
                res.SetValue("return_code", "FAIL");
                res.SetValue("return_msg", "订单查询失败");
                page.Response.Write(res.ToXml());
                page.Response.End();
            }
            //查询订单成功
            else
            {
                string out_trade_no = notifyData.GetValue("out_trade_no").ToString();
                string trade_no = transaction_id;
                string result_code = notifyData.GetValue("result_code").ToString();
                //金额回传原始为分，转换成元
                decimal total_fee = Convert.ToDecimal(notifyData.GetValue("total_fee").ToString()) / 100;
                //支付成功
                if (result_code == "SUCCESS")
                {
                    var type = out_trade_no.Substring(0, 2);
                    if (type == BillType.VIP_BUY)
                    {
                        //充值购买
                        AlipayNotifyHelper.FinishBuy(out_trade_no, PayOption.WEIXIN.Id, trade_no, total_fee);
                    }
                    else if (type == BillType.VIP_USE)
                    {
                        //消费支付
                        AlipayNotifyHelper.FinishUse(out_trade_no, PayOption.WEIXIN.Id, trade_no, total_fee);
                    }
                }

                WxPayData res = new WxPayData();
                res.SetValue("return_code", "SUCCESS");
                res.SetValue("return_msg", "OK");
                page.Response.Write(res.ToXml());
                page.Response.End();
            }
        }

        //查询订单
        private bool QueryOrder(string transaction_id)
        {
            WxPayData req = new WxPayData();
            req.SetValue("transaction_id", transaction_id);
            WxPayData res = WxPayApi.OrderQuery(req);
            var isSucces = res.GetValue("return_code").ToString() == "SUCCESS" && res.GetValue("result_code").ToString() == "SUCCESS";

            return isSucces;
        }
    }
}