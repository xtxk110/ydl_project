using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    /// <summary>
    /// 获取比赛团队列表条件
    /// </summary>
    public class GetGameTeamListFilter : FilterBase
    {
        /// <summary>
        /// 比赛编号
        /// </summary>
        public string GameId { get; set; }

        /// <summary>
        /// 名称
        /// </summary>
        public string TeamName { get; set; }

        /// <summary>
        /// 审核状态
        /// </summary>
        public string State { get; set; }

        /// <summary>
        /// 是否没进入小组分组
        /// </summary>
        public bool OnlyNotGroup { get; set; }
    }
}
