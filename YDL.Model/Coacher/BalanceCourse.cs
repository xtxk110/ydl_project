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
    /// 学员余额实体
    /// </summary>
    [Table]
    public class BalanceCourse : EntityBase
    {

        public BalanceCourse()
        {
            CoacherCourse = new BalanceCourseType();
        }
        /// <summary>
        /// 余额Id
        /// </summary>
        [Field(isUpdate: false)]
        public string Id { get; set; }

        /// <summary>
        /// 教练Id
        /// </summary>
        [Field(isUpdate: false)]
        public string CoacherUserId { get; set; }

        /// <summary>
        /// 教练名称
        /// </summary>
        [Field(isUpdate: false)]
        public string CoacherName { get; set; }
        /// <summary>
        /// 教练等级
        /// </summary>
        [Field(isUpdate: false)]
        public int CoacherGrade { get; set; }
        /// <summary>
        /// 体验课状态
        /// </summary>
        public string ExperienceCourseState { get; set; }
        /// <summary>
        /// 教练课程列表
        /// </summary>
        public BalanceCourseType CoacherCourse { get; set; }
    }

    public class BalanceCourseType
    {
        public BalanceCourseType()
        {
            BigCourse = new List<CoachStudentMoney>();
            SmallCourse = new List<Model.CoachStudentMoney>();
            PrivateCourse = new List<Model.CoachStudentMoney>();
        }
        public List<CoachStudentMoney> BigCourse { get; set; }


        public List<CoachStudentMoney> SmallCourse { get; set; }

        public List<CoachStudentMoney> PrivateCourse { get; set; }
    }
}