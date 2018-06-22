using YDL.Core;

namespace YDL.Model
{
    /// <summary>
    /// 用户积分历史记录
    /// </summary>
    [Table(name:"UserScoreHistory")]
    public class ScoreHistory : EntityBase
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
        /// 增减积分；
        /// 手动修改积分时，为修改后积分
        /// </summary>
        [Field]
        public int Score { get; set; }

        /// <summary>
        /// 手动修改积分时，老的积分
        /// </summary>
        [Field(dataType: DataType.Int32)]
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
        /// <summary>
        /// 赛事名称
        /// </summary>
        [Field]
        public string GameName { get; set; }
        /// <summary>
        /// 积分修改描述
        /// </summary>
        public string Description { get; set; }
        /// <summary>
        /// 积分字符串
        /// </summary>
        public string ScoreStr { get; set; }
    }
}
