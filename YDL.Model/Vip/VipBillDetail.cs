using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Core;
using YDL.Utility;

namespace YDL.Model
{
    /// <summary>
    /// 结算单明细
    /// </summary>
    public class VipBillDetail : EntityBase
    {
        /// <summary>
        /// 结算单号
        /// </summary>
        [Field]
        public string BillId { get; set; }

        /// <summary>
        /// 费用类型
        /// </summary>
        [Field]
        public string CostTypeId { get; set; }

        /// <summary>
        /// 金额
        /// </summary>
        [Field(dataType: DataType.Decimal)]
        public decimal Amount { get; set; }

        /// <summary>
        /// 隐藏基类属性
        /// </summary>
        public new DateTime CreateDate { get; set; }
    }
}
