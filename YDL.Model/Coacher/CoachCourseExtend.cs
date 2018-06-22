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
    /// 教练课程扩展字段(用于返回更少数据)
    /// </summary>
    [Table]
    public class CoachCourseExtend : HeadBase
    {
        /// <summary>
        /// 教练有课日期
        /// </summary>
        [Field(IsUpdate = false)]
        public DateTime CoachHaveCourseDate { get; set; }

  

    }
}