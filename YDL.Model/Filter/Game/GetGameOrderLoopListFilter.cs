using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    /// <summary>
    /// 获取轮次场次列表条件
    /// </summary>
    public class GetGameOrderLoopListFilter:FilterBase
    {
        /// <summary>
        /// 比赛编号
        /// </summary>
        public string GameId { get; set; }

        /// <summary>
        /// 淘汰赛AB组类型
        /// </summary>
        public string KnockOutAB { get; set; }

        /// <summary>
        /// 轮次编号
        /// </summary>
        public string OrderId { get; set; }

        /// <summary>
        /// 小组编号
        /// </summary>
        public string GroupId { get; set; }

        /// <summary>
        /// 小组序号
        /// </summary>
        public int GroupOrderNo { get; set; }

        /// <summary>
        /// 获取附加赛选项
        /// </summary>
        public string IsExtra { get; set; }

        /// <summary>
        /// 每个小组的轮次号
        /// </summary>
        public int OrderNo { get; set; }
        /// <summary>
        /// 开始时间
        /// </summary>
        public string StartTime { get; set; }
        /// <summary>
        /// 结束时间
        /// </summary>
        public string EndTime { get; set; }
        /// <summary>
        /// 队伍1ID
        /// </summary>
        public string Team1Id { get; set; }
        /// <summary>
        /// 队伍2ID
        /// </summary>
        public string Team2Id { get; set; }
        /// <summary>
        /// 球桌号
        /// </summary>
        public int TableNo { get; set; }

    }
}
