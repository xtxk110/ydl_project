using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    public class GetVipRefundListFilter : FilterBase
    {
        /// <summary>
        /// 用户编号
        /// </summary>
        public String UserId { get; set; }

        /// <summary>
        /// 状态
        /// </summary>
        public String State { get; set; }

        /// <summary>
        /// 开始日期
        /// </summary>
        public String BeginDate { get; set; }

        /// <summary>
        /// 截止日期
        /// </summary>
        public String EndDate { get; set; }
    }
}
