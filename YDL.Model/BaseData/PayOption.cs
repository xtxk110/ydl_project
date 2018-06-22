using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    public class PayOption
    {
        public static readonly BaseData REMAIN = new BaseData { Id = "023001", Name = "余额支付" };
        public static readonly BaseData ALIPAY = new BaseData { Id = "023002", Name = "支付宝" };
        public static readonly BaseData VENUE_CREDIT = new BaseData { Id = "023003", Name = "信用额度" };
        public static readonly BaseData WEIXIN = new BaseData { Id = "023004", Name = "微信支付" };
        public static readonly BaseData YUEDOUPAY = new BaseData { Id = "023005", Name = "悦豆支付" };

        public static List<BaseData> GetItems(bool containAllItem)
        {
            var result = new List<BaseData> { REMAIN, ALIPAY, WEIXIN };
            if (containAllItem)
            {
                result.Insert(0, BaseData.ALL_ITEM);
            }
            return result;
        }
    }
}
