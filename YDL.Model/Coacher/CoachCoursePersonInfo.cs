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
    public class CoachCoursePersonInfo : HeadBase
    {
        public CoachCoursePersonInfo()
        {

        }

        /// <summary>
        /// 约课Id
        /// </summary>
        [Field]
        public string CourseId { get; set; }

        /// <summary>
        /// 学员姓名
        /// </summary>
        [Field]
        public string StudentName { get; set; }

        /// <summary>
        /// 电话
        /// </summary>
        [Field]
        public string StudentMobile { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        [Field]
        public string StudentRemark { get; set; }

        /// <summary>
        /// 目标Code
        /// </summary>
        [Field]
        public string CourseGoalCode { get; set; }

        /// <summary>
        /// 悦动力用户账户Id
        /// </summary>
        [Field]
        public string YdlUserId { get; set; }

        public string Sex { get; set; }
        /// <summary>
        /// 剩余次数
        /// </summary>
        public int Amount { get; set; }
        /// <summary>
        /// 总次数
        /// </summary>
        public int ThenTotalAmount { get; set; }

        /// <summary>
        /// 是否签到
        /// </summary>
        [Field]
        public bool IsSignIn { get; set; }

        public string CourseType { get; set; }

        /// <summary>
        /// 评价学员信息
        /// </summary>
        public CoachCommentStudent CoachCommentStudentInfo { get; set; }

        /// <summary>
        /// 课程内容
        /// </summary>
        [Field(IsUpdate = false)]
        public string CourseContent { get; set; }

        /// <summary>
        /// 常用学员Id
        /// </summary>
        [Field]
        public string FrequentStudentId { get; set; }


    }
}