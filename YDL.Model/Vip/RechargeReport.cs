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
    /// 充值统计报表
    /// </summary>
    [Table]
    public class RechargeReport : EntityBase
    {
        /// <summary>
        /// 月份
        /// </summary>
        [Field(isUpdate: false)]
        public string Month { get; set; }

        /// <summary>
        /// 充值金额
        /// </summary>
        [Field(dataType: DataType.Decimal, isUpdate: false)]
        public decimal Amount { get; set; }

        /// <summary>
        /// 配送金额
        /// </summary>
        [Field(dataType: DataType.Decimal, isUpdate: false)]
        public decimal GiveAmount { get; set; }

        /// <summary>
        /// 总额
        /// </summary>
        [Field(dataType: DataType.Decimal, isUpdate: false)]
        public decimal Total { get; set; }
    }
}
