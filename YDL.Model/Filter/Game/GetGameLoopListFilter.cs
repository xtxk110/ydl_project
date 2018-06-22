using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    /// <summary>
    /// 获取比赛列表条件
    /// </summary>
    public class GetGameLoopListFilter : FilterBase
    {
        /// <summary>
        /// 比赛编号
        /// </summary>
        public string GameId { get; set; }

        /// <summary>
        /// 队伍名称
        /// </summary>
        public string TeamName { get; set; }

        /// <summary>
        /// 桌子号
        /// </summary>
        public int TableNo { get; set; }

        /// <summary>
        /// 单场比赛状态
        /// </summary>
        public string State { get; set; }

        /// <summary>
        /// 比赛时间
        /// </summary>
        public DateTime? BeginTime { get; set; }
    }
}
