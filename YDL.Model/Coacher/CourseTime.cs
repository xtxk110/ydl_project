using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using YDL.Core;
using YDL.Utility;

namespace YDL.Model
{

    [Table]
    public class CourseTime : HeadBase
    {
        /// <summary>
        /// 开始时间
        /// </summary>
        [Field(dataType: DataType.DateTime)]
        public DateTime? BeginTime { get; set; }

        /// <summary>
        /// 是否有课
        /// </summary>
        [Field(IsUpdate = false)]
        public bool IsHaveCourse { get; set; }
    }
}