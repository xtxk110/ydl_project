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
    /// 学员预约集训的课程
    /// </summary>
    [Table]
    public class CoachBootcampCourseJoin : EntityBase
    {
        /// <summary>
        /// 学员Id 
        /// </summary>
        [Field]
        public string StudentId { get; set; }
        /// <summary>
        /// 集训的课程Id 
        /// </summary>
        [Field]
        public string BootcampCourseId { get; set; }

        /// <summary>
        /// 集训的Id 
        /// </summary>
        public string CoachBootcampId { get; set; }


    }
}