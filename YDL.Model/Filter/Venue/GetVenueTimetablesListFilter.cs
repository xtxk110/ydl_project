using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using YDL.Core;

namespace YDL.Model
{
    /// <summary>
    /// 获取课程表
    /// </summary>
    public class GetVenueTimetablesListFilter : EntityBase
    {
        /// <summary>
        /// 
        /// </summary>
        public string VenueId { get; set; }

        /// <summary>
        /// 是否包含指定日期的课程
        /// </summary>
        public bool? IncludeCourse { get; set; }

        /// <summary>
        /// (包含课程时)指定日期
        /// </summary>
        public DateTime? CurDate { get; set; }
    }
}
