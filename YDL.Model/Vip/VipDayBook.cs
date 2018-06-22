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
    /// 购买记录
    /// </summary>
    [Table]
    public class VipDayBook : EntityBase
    {
        /// <summary>
        /// 单据类型
        /// </summary>
        [Field]
        public string MasterType { get; set; }

        /// <summary>
        /// 支付类型
        /// </summary>
        [Field]
        public string PayOption { get; set; }

        /// <summary>
        /// 金额
        /// </summary>
        [Field(dataType: DataType.Decimal)]
        public decimal Amount { get; set; }

        /// <summary>
        /// 附加金额
        /// </summary>
        [Field(dataType: DataType.Decimal)]
        public decimal OtherAmount { get; set; }

        /// <summary>
        /// 用户编号
        /// </summary>
        [Field]
        public string UserId { get; set; }

        /// <summary>
        /// 交易日期
        /// </summary>
        [Field(dataType: DataType.DateTime)]
        public DateTime PayDate { get; set; }
    }
}
