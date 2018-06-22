using System.ComponentModel;
namespace YDL.Model
{
    /// <summary>
    /// 权限的业务模块类型
    /// </summary>
    public enum RightModuleOpType
    {
        /// <summary>
        /// 教练
        /// </summary>
        [Description("教练")]
        CoachOper,
        /// <summary>
        /// 赛事
        /// </summary>
        [Description("赛事")]
        GameOper,
        /// <summary>
        /// 活动
        /// </summary>
        [Description("活动")]
        ActivityOper,
        /// <summary>
        /// 俱乐部
        /// </summary>
        [Description("俱乐部")]
        ClubOper,
        /// <summary>
        /// 场馆
        /// </summary>
        [Description("场馆")]
        VenueOper,
        /// <summary>
        /// 场馆收入统计
        /// </summary>
        [Description("场馆收入统计")]
        VenueStatistics,
        /// <summary>
        /// 场馆收款
        /// </summary>
        [Description("场馆收款")]
        VenueGetMoney,
        /// <summary>
        /// 创建直播
        /// </summary>
        [Description("创建直播")]
        LiveAdd,
        /// <summary>
        /// 创建竞猜
        /// </summary>
        [Description("创建竞猜")]
        GuessAdd,
        /// <summary>
        /// 创建积分赛
        /// </summary>
        [Description("创建积分赛")]
        ScoreGameAdd
    }
}
