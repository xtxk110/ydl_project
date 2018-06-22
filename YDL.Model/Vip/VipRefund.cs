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
    /// 退款记录
    /// </summary>
    [Table]
    public class VipRefund : EntityBase
    {
        /// <summary>
        /// 流水号
        /// </summary>
        [Field]
        public string OrderNo { get; set; }

        /// <summary>
        /// 退款人
        /// </summary>
        [Field]
        public string UserId { get; set; }

        /// <summary>
        /// 申请金额
        /// </summary>
        [Field(dataType: DataType.Decimal)]
        public decimal AppliedAmount { get; set; }

        /// <summary>
        /// 实退金额
        /// </summary>
        [Field(dataType: DataType.Decimal)]
        public decimal Amount { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        [Field]
        public string Remark { get; set; }

        /// <summary>
        /// 创建人
        /// </summary>
        [Field]
        public string CreatorId { get; set; }
    }
}
