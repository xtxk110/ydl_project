using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    public enum SerialNoType
    {
        /// <summary>
        /// 充值记录01
        /// </summary>
        VipBuy,

        /// <summary>
        /// 消费记录02
        /// </summary>
        VipUse,

        /// <summary>
        /// 结算单03
        /// </summary>
        VenueBill,

        /// <summary>
        /// 退款单04
        /// </summary>
        VipRefund
    }
}
