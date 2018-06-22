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
    /// 学员余额实体(+最后上课时间)
    /// </summary>
    [Table]
    public class CoachStudentBalance : EntityBase
    {
        /// <summary>
        /// 余额次数
        /// </summary>
        public decimal Amount { get; set; }
        /// <summary>
        /// 总次数
        /// </summary>
        public decimal TotalAmount { get; set; }

        /// <summary>
        /// 最后上课时间
        /// </summary>
        public DateTime? LastGoCourseTime { get; set; }

    }

}