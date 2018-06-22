using YDL.Core;

namespace YDL.Model
{
    /// <summary>
    /// 用户权限申请
    /// </summary>
    [Table]
    public class UserLimitRequest : EntityBase
    {
        /// <summary>
        /// 用户编号
        /// </summary>
        [Field]
        public string UserId { get; set; }

        /// <summary>
        /// 创建俱乐部
        /// </summary>
        [Field(dataType: DataType.Boolean)]
        public bool IsClub { get; set; }

        /// <summary>
        /// 创建场馆
        /// </summary>
        [Field(dataType: DataType.Boolean)]
        public bool IsVenue { get; set; }

        /// <summary>
        /// 创建比赛
        /// </summary>
        [Field(dataType: DataType.Boolean)]
        public bool IsGame { get; set; }

        /// <summary>
        /// 创建活动
        /// </summary>
        [Field(dataType: DataType.Boolean)]
        public bool IsActivity { get; set; }

        /// <summary>
        /// 创建笔记
        /// </summary>
        [Field(dataType: DataType.Boolean)]
        public bool IsNote { get; set; }

        /// <summary>
        /// 说明
        /// </summary>
        [Field]
        public string Remark { get; set; }

        /// <summary>
        /// 系统是否已处理
        /// </summary>
        [Field(dataType: DataType.Boolean)]
        public bool IsProcessed { get; set; }
    }
}
