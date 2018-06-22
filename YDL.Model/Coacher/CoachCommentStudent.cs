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
    /// 教练评价学员
    /// </summary>
    [Table]
    public class CoachCommentStudent : HeadBase
    {

        /// <summary>
        /// 学员个人信息表Id
        /// </summary>
        [Field]
        public string CoursePersonInfoId { get; set; }

        /// <summary>
        /// 学员悦动力账户Id(有值表示学员在悦动力有账户, 没值表示学员是临时的)
        /// </summary>
        [Field]
        public string YdlUserId { get; set; }

        /// <summary>
        /// 课程总结
        /// </summary>
        [Field]
        public string CourseSummary { get; set; }

        /// <summary>
        /// 技术类别Id
        /// </summary>
        [Field]
        public string TeachTypeId { get; set; }

        /// <summary>
        /// 技术类别Name
        /// </summary>
        [Field(IsUpdate = false)]
        public string TeachTypeName { get; set; }

        /// <summary>
        /// 评价人id
        /// </summary>
        [Field]
        public string CommentatorId { get; set; }

        public string CourseId { get; set; }

    }
}