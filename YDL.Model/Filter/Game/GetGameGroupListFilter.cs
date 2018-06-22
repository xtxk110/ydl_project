using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    /// <summary>
    /// 获取比赛小组条件
    /// </summary>
    public class GetGameGroupListFilter
    {
        /// <summary>
        /// 比赛编号
        /// </summary>
        public string GameId { get; set; }

        /// <summary>
        /// 小组编号
        /// </summary>
        public string GroupId { get; set; }

        /// <summary>
        /// 是否获取小组成员
        /// </summary>
        public bool IsContainMember { get; set; }

        /// <summary>
        /// 是否获取小组比赛
        /// </summary>
        public bool IsContainLoop { get; set; }
    }
}
