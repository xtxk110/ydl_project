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
    public class VipBuy : EntityBase
    {
        /// <summary>
        /// 流水号
        /// </summary>
        [Field]
        public string OrderNo { get; set; }

        /// <summary>
        /// 金额
        /// </summary>
        [Field(dataType: DataType.Decimal)]
        public decimal Amount { get; set; }

        /// <summary>
        /// 赠送比率
        /// </summary>
        [Field(dataType: DataType.Decimal)]
        public decimal GiveScale { get; set; }

        /// <summary>
        /// 赠送金额
        /// </summary>
        [Field(dataType: DataType.Decimal)]
        public decimal GiveAmount { get; set; }

        /// <summary>
        /// 支付方式
        /// </summary>
        [Field]
        public string PayOption { get; set; }

        /// <summary>
        /// 支付编号
        /// </summary>
        [Field]
        public string PayId { get; set; }

        /// <summary>
        /// 支付状态
        /// </summary>
        [Field]
        public string PayState { get; set; }

        /// <summary>
        /// 支付日期
        /// </summary>
        [Field(dataType: DataType.DateTime)]
        public DateTime? PayDate { get; set; }

        /// <summary>
        /// 支付备注
        /// </summary>
        [Field]
        public string PayRemark { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        [Field]
        public string Remark { get; set; }

        /// <summary>
        /// 实际充值人
        /// </summary>
        [Field]
        public string UserId { get; set; }

        /// <summary>
        /// 创建人
        /// </summary>
        [Field]
        public string CreatorId { get; set; }

        /// <summary>
        /// 创建日期1
        /// </summary>
        [Field(dataType: DataType.Date, onlyInsert: true)]
        public DateTime CreateDate1 { get; set; }

        /// <summary>
        /// 支付人姓名昵称
        /// </summary>
        [Field(IsUpdate = false)]
        public string CardName { get; set; }
    }
}
