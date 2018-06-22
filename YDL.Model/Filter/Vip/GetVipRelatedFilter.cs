using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    /// <summary>
    /// 获取Vip 相关 Filter
    /// </summary>
    public class GetVipRelatedFilter : FilterBase
    {
        /// <summary>
        /// 主体Id
        /// </summary>
        public string MasterId { get; set; }

        /// <summary>
        /// 业务类型
        /// </summary>
        public string BusinessType { get; set; }

        /// <summary>
        /// 支付类型 枚举值 两个: Buy 和 Use
        /// </summary>
        public string PayType { get; set; }

        /// <summary>
        /// 支付Id
        /// </summary>
        public string PayId { get; set; }

      
    }
}
