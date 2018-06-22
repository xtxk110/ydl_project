using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    public class PayState
    {
        public static readonly BaseData PAY = new BaseData { Id = "024001", Name = "待付款" };
        public static readonly BaseData SUCCESS = new BaseData { Id = "024002", Name = "支付成功" };
        public static readonly BaseData FAIL = new BaseData { Id = "024003", Name = "支付失败" };
        public static readonly BaseData CANCEL = new BaseData { Id = "024009", Name = "已取消" };

        public static List<BaseData> GetItems(bool containAllItem)
        {
            var result = new List<BaseData> { PAY, SUCCESS, FAIL };
            if (containAllItem)
            {
                result.Insert(0, BaseData.ALL_ITEM);
            }
            return result;
        }
    }
}
