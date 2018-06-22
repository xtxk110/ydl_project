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
    /// 会员账户
    /// </summary>
    [Table]
    public class VipAccount : EntityBase
    {
        /// <summary>
        /// 用户编号为基类Id
        /// </summary>

        /// <summary>
        /// 用户帐号
        /// </summary>
        [Field(isUpdate: false)]
        public string UserCode { get; set; }
        
        /// <summary>
        /// 用户姓名
        /// </summary>
        [Field(isUpdate: false)]
        public string UserName { get; set; }

        /// <summary>
        /// 总金额
        /// </summary>
        [Field(dataType: DataType.Decimal)]
        public decimal Amount { get; set; }

        // <summary>
        /// 已用金额
        /// </summary>
        [Field(dataType: DataType.Decimal)]
        public decimal UsedAmount { get; set; }

        // <summary>
        /// 账户余额
        /// </summary>
        [Field(dataType: DataType.Decimal)]
        public decimal Balance { get; set; }

        // <summary>
        /// 退款总额
        /// </summary>
        [Field(dataType: DataType.Decimal)]
        public decimal Refund { get; set; }

        // <summary>
        /// 总积分
        /// </summary>
        [Field(dataType: DataType.Decimal)]
        public decimal Score { get; set; }

        // <summary>
        /// 已用积分
        /// </summary>
        [Field(dataType: DataType.Decimal)]
        public decimal UsedScore { get; set; }

        // <summary>
        /// 积分余额
        /// </summary>
        [Field(dataType: DataType.Decimal)]
        public decimal BalanceScore { get; set; }

        ///<summary>
        /// 充值待支付订单数
        /// </summary>
        [Field(dataType: DataType.Int32,isUpdate:false)]
        public int PayCount { get; set; }

        ///<summary>
        /// 消费待支付订单数
        /// </summary>
        [Field(dataType: DataType.Int32, isUpdate: false)]
        public int PayUseCount { get; set; }

        /// <summary>
        /// 悦豆余额
        /// </summary>
        public int YueDouBalance { get; set; }

    }
}
