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
    /// 大课信息
    /// </summary>
    [Table]
    public class CoachBigCourseInfo : HeadBase
    {
        public CoachBigCourseInfo()
        {
        }
     
        /// <summary>
        /// 大课名称
        /// </summary>
        [Field]
        public string Name { get; set; }

        /// <summary>
        /// 价格
        /// </summary>
        [Field]
        public decimal Price { get; set; }
        /// <summary>
        /// 课程内容
        /// </summary>
        [Field]
        public string Content { get; set; }

        /// <summary>
        /// 教练价格Id
        /// </summary>
        [Field]
        public string CoachPriceId { get; set; }

        /// <summary>
        /// 课程内容
        /// </summary>
        [Field]
        public string CourseContent { get; set; }

    }
}