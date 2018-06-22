using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    public class GetVipVenueBillDetailListFilter : FilterBase
    {
        /// <summary>
        /// 支付日期或者创建日期
        /// </summary>
        public bool IsPayDate { get; set; }

        /// <summary>
        /// 支付状态
        /// </summary>
        public String PayState { get; set; }

        /// <summary>
        /// 场馆编号
        /// </summary>
        public String VenueId { get; set; }

        /// <summary>
        /// 开始日期
        /// </summary>
        public DateTime BeginDate { get; set; }

        /// <summary>
        /// 截止日期
        /// </summary>
        public DateTime EndDate { get; set; }
    }
}
