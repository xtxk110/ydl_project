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
    /// 课程详情--点评学员
    /// </summary>
    [Table]
    public class CoachStudentRemark : EntityBase
    {

        /// <summary>
        /// 课程Id 
        /// </summary>
        [Field]
        public string CourseId { get; set; }

        /// <summary>
        /// 学员Id 
        /// </summary>
        [Field]
        public string StudentId { get; set; }
        /// <summary>
        /// 学员评语 
        /// </summary>
        [Field]
        public string Remark { get; set; }

        /// <summary>
        /// 评语人(谁评语记录谁的Id) 
        /// </summary>
        [Field]
        public string RemarkUserId { get; set; }
    }
}