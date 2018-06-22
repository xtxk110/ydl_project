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
    /// 用户运动爱好
    /// </summary>
    [Table]
    public class UserSport : EntityBase
    {
        /// <summary>
        /// 用户
        /// </summary>

        [Field]
        public string UserId { get; set; }

        /// <summary>
        /// 运动类别
        /// </summary>
        [Field]
        public string SportId { get; set; }

        /// <summary>
        /// 现役
        /// </summary>

        [Field(dataType: DataType.Boolean)]
        public bool IsActive { get; set; }

        /// <summary>
        /// 专业/业余
        /// </summary>

        [Field]
        public string ProType { get; set; }

        /// <summary>
        /// 握拍方式
        /// </summary>

        [Field]
        public string GripOption { get; set; }

        /// <summary>
        /// 积分
        /// </summary>

        [Field(dataType: DataType.Int32)]
        public int Score { get; set; }

        /// <summary>
        /// 段位名
        /// </summary>
        [Field(isUpdate:false)]
        public string GradeName { get; set; }
        /// <summary>
        /// 段位索引
        /// </summary>
        [Field]
        public int GradeIndex { get; set; }
        /// <summary>
        /// 当前段位左值
        /// </summary>
        [Field]
        public decimal LeftScore { get; set; }
        /// <summary>
        /// 当前段位右值
        /// </summary>
        [Field]
        public decimal RightScore { get; set; }
        /// <summary>
        /// 段位前一段的最高值
        /// </summary>

        public decimal PreLeftScore { get; set; }
        /// <summary>
        /// 段位前一段的段位名
        /// </summary>

        public string PreLeftGradeName { get; set; }
        /// <summary>
        /// 段位后一段的最低值
        /// </summary>

        public decimal NextRightScore { get; set; }
        /// <summary>
        /// 段位后一段的段位名
        /// </summary>

        public string NextRightGradeName { get; set; }
    }
}
