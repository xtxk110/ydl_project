using YDL.Core;

namespace YDL.Model
{
    /// <summary>
    /// 用户积分历史记录
    /// </summary>
    [Table]
    public class UserScoreHistory : EntityBase
    {
        /// <summary>
        /// 用户编号
        /// </summary>
        [Field]
        public string UserId { get; set; }

        /// <summary>
        /// 运动类型
        /// </summary>
        [Field]
        public string SportId { get; set; }

        /// <summary>
        /// 赛事编号
        /// </summary>
        [Field]
        public string GameId { get; set; }

        /// <summary>
        /// 场次编号
        /// </summary>
        [Field]
        public string LoopId { get; set; }

        /// <summary>
        /// 队伍1
        /// </summary>
        [Field]
        public string User1Id { get; set; }

        /// <summary>
        /// 队伍2
        /// </summary>
        [Field]
        public string User2Id { get; set; }

        /// <summary>
        /// 增减积分；
        /// 手动修改积分时，为修改后积分
        /// </summary>
        [Field]
        public string Score { get; set; }

        /// <summary>
        /// 手动修改积分时，老的积分
        /// </summary>
        [Field(dataType:DataType.Int32)]
        public int OldScore { get; set; }

        /// <summary>
        /// 团队积分赛时，每个map对应一场个人比赛
        /// </summary>
        [Field]
        public string MapId { get; set; }

        /// <summary>
        /// 是否是手动修改积分
        /// </summary>
        [Field(dataType: DataType.Boolean)]
        public bool IsEdit { get; set; }

        /// <summary>
        /// 手动修改积分的修改者
        /// </summary>
        [Field]
        public string Editor { get; set; }
    }
}
