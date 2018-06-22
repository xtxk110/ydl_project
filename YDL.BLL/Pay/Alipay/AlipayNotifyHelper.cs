using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;

using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Utility;
using YDL.Core;
using Com.Alipay;
using System.Web;

namespace YDL.BLL
{
    /// <summary>
    /// 结算支付通知帮助类
    /// </summary>
    public class AlipayNotifyHelper
    {
        private static string GetAlipaySign()
        {
            return ConfigurationManager.AppSettings["alipaysign"];
        }

        /// <summary>
        /// 充值支付
        /// </summary>
        /// <param name="orderNo"></param>
        /// <param name="payOption"></param>
        /// <param name="payId"></param>
        /// <param name="amount"></param>
        /// <returns></returns>
        public static bool FinishBuy(string orderNo, string payOption, string payId, decimal amount)
        {
            var cmd = CommandHelper.CreateProcedure(FetchType.Execute, "sp_SaveVipBuyPay");
            cmd.Params.Add("@id", null);
            cmd.Params.Add("@orderNo", orderNo);
            cmd.Params.Add("@amount", amount, DataType.Decimal);
            cmd.Params.Add("@payOption", payOption);
            cmd.Params.Add("@payId", payId);
            cmd.Params.Add("@payState", PayState.SUCCESS.Id);
            cmd.Params.Add("@payRemark", null);
            cmd.CreateParamMsg();

            var result = DbContext.GetInstance().Execute(cmd);
            return result.IsSuccess;
        }

        /// <summary>
        /// 消费支付
        /// </summary>
        /// <param name="orderNo"></param>
        /// <param name="payOption"></param>
        /// <param name="payId"></param>
        /// <param name="amount"></param>
        /// <returns></returns>
        public static bool FinishUse(string orderNo, string payOption, string payId, decimal amount)
        {
            var cmd = CommandHelper.CreateProcedure(FetchType.Execute, "sp_SaveVipUsePay");
            cmd.Params.Add("@id", null);
            cmd.Params.Add("@orderNo", orderNo);
            cmd.Params.Add("@amount", amount, DataType.Decimal);
            cmd.Params.Add("@payPassword", string.Empty);
            cmd.Params.Add("@payOption", payOption);
            cmd.Params.Add("@payId", payId);
            cmd.Params.Add("@payState", PayState.SUCCESS.Id);
            cmd.Params.Add("@payRemark", null);
            cmd.CreateParamMsg();

            var result = DbContext.GetInstance().Execute(cmd);
            return result.IsSuccess;
        }

        /// <summary>
        /// 场馆结算支付
        /// </summary>
        /// <param name="orderNo"></param>
        /// <param name="payOption"></param>
        /// <param name="payId"></param>
        /// <param name="amount"></param>
        /// <returns></returns>
        public static bool FinishVenueBill(string orderNo, string payOption, string payId, decimal amount)
        {
            var cmd = CommandHelper.CreateProcedure(FetchType.Execute, "sp_SaveVenueBillPay");
            cmd.Params.Add("@id", null);
            cmd.Params.Add("@orderNo", orderNo);
            cmd.Params.Add("@amount", amount, DataType.Decimal);
            cmd.Params.Add("@payOption", payOption);
            cmd.Params.Add("@payId", payId);
            cmd.Params.Add("@payState", PayState.SUCCESS.Id);
            cmd.Params.Add("@payRemark", null);
            cmd.CreateParamMsg();

            var result = DbContext.GetInstance().Execute(cmd);
            return result.IsSuccess;
        }

        /// <summary>
        /// 退款支付
        /// </summary>
        /// <param name="orderNo"></param>
        /// <param name="payOption"></param>
        /// <param name="payId"></param>
        /// <param name="amount"></param>
        /// <returns></returns>
        public static bool FinishRefund(string orderNo, string payOption, string payId, decimal amount)
        {
            var cmd = CommandHelper.CreateProcedure(FetchType.Execute, "sp_SaveVipRefundPay");
            cmd.Params.Add("@id", null);
            cmd.Params.Add("@orderNo", orderNo);
            cmd.Params.Add("@amount", amount, DataType.Decimal);
            cmd.Params.Add("@payOption", payOption);
            cmd.Params.Add("@payId", payId);
            cmd.Params.Add("@payState", PayState.SUCCESS.Id);
            cmd.Params.Add("@payRemark", null);
            cmd.CreateParamMsg();

            var result = DbContext.GetInstance().Execute(cmd);
            return result.IsSuccess;
        }
    }
}
