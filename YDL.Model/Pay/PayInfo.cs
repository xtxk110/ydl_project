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
    /// 支付对象信息
    /// </summary>
    public class PayInfo : EntityBase
    {
        /// <summary>
        /// 支付宝帐号
        /// </summary>
        public string AlipayId { get; set; }

        /// <summary>
        /// 支付类型
        /// </summary>
        public string PayOption { get; set; }

        /// <summary>
        /// 支付金额
        /// </summary>
        public decimal PayAmount { get; set; }

        /// <summary>
        /// 业务类型
        /// </summary>
        public string BillType { get; set; }

        /// <summary>
        /// 业务单号(相关单据OrderNo)
        /// </summary>
        public string BillId { get; set; }

        /// <summary>
        /// 用户编号
        /// </summary>
        public string UserId { get; set; }

        /// <summary>
        /// 用户名称
        /// </summary>
        public string UserName { get; set; }

        
    }
}
