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
    /// 集训的课程表
    /// </summary>
    public class CoachBootcampSyllabus :EntityBase
    {
        public CoachBootcampSyllabus()
        {
            CourseList = new List<CoachBootcampCourse>();
        }
        /// <summary>
        /// 日期
        /// </summary>
        public DateTime Date { get; set; }
        /// <summary>
        /// 星期几
        /// </summary>
        public string DayOfWeek { get; set; }
        /// <summary>
        /// 课程
        /// </summary>
        public List<CoachBootcampCourse> CourseList { get; set; }

     


    }
}