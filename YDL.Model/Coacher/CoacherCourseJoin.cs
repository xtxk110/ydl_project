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
    /// 课程报名表
    /// </summary>
    [Table]
    public class CoachCourseJoin : EntityBase
    {
        /// <summary>
        /// 学员Id 
        /// </summary>
        [Field]
        public string StudentId { get; set; }
        /// <summary>
        /// 课程Id 
        /// </summary>
        [Field]
        public string CourseId { get; set; }

        /// <summary>
        /// 教练Id 
        /// </summary>
        [Field]
        public string CoachId { get; set; }


        /// <summary>
        /// 城市Id
        /// </summary>
        [Field(IsUpdate =false)]
        public string CityId { get; set; }

        /// <summary>
        /// 当时的课程单价 
        /// </summary>
        [Field]
        public decimal ThenCourseUnitPrice { get; set; }

        

    }
}