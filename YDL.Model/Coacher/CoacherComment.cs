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
    /// 教练评论表
    /// </summary>
    [Table]
    public class CoachComment : HeadBase
    {
        /// <summary>
        /// 教练Id 
        /// </summary>
        [Field]
        public string CoacherUserId { get; set; }

        /// <summary>
        /// 课程Id 
        /// </summary>
        [Field]
        public string CourseId { get; set; }

        /// <summary>
        /// 评分
        /// </summary>
        [Field(dataType: DataType.Decimal)]
        public decimal Score { get { return scoreValue; } set { scoreValue = Helper.GetRoundOffByIEEE(value, 1); } }
        public decimal scoreValue;


        /// <summary>
        /// 评论 
        /// </summary>
        [Field]
        public string Comment { get; set; }


        /// <summary>
        /// 评论人Id
        /// </summary>
        [Field]
        public string CommentatorId { get; set; }
        /// <summary>
        /// 评论人Name
        /// </summary>
        [Field(isUpdate:false)]
        public string CommentatorName { get; set; }

        /// <summary>
        /// 评论人名称是否公开
        /// </summary>
        [Field(dataType: DataType.Boolean)]
        public bool IsShareName { get; set; }

        /// <summary>
        /// 评论人性别
        /// </summary>
        [Field(isUpdate: false)]
        public string Sex { get; set; }
    }
}