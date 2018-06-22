using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Map;
using YDL.Model;

namespace YDL.BLL
{
    class PayHelper
    {
        public static PayHelper Instance = new PayHelper();
        public static void GetSubjectAndBody(PayInfo info, out string subject, out string body)
        {
            if (info.BillType == BillType.VIP_BUY)
            {
                subject = string.Format("悦动力会员『{0}』充值", info.UserName);
                body = "会员充值";
            }
            else if (info.BillType == BillType.VIP_USE)
            {
                subject = string.Format("悦动力会员『{0}』消费", info.UserName);
                body = "场地消费";
            }
            else if (info.BillType == BillType.VIP_VENUE_BILL)
            {
                subject = string.Format("悦动力场馆『{0}』结算", info.UserName);
                body = "场馆结算";
            }
            else if (info.BillType == BillType.VIP_REFUND)
            {
                subject = string.Format("悦动力会员『{0}』退款", info.UserName);
                body = "会员退款";
            }
            else
            {
                subject = string.Empty;
                body = string.Empty;
            }
        }

        public int GetYueDouBalance(string userId)
        {
            var sql = @"
SELECT * FROM dbo.YueDou WHERE UserId=@UserId
";
            var cmd = CommandHelper.CreateText<YueDou>(FetchType.Fetch, sql);
            cmd.Params.Add("@UserId", userId);
            var result = DbContext.GetInstance().Execute(cmd);
            var obj = result.FirstEntity<YueDou>();
            if (obj != null)
            {
                return obj.Balance;
            }
            else
            {
                return 0;
            }
        }
    }
}
