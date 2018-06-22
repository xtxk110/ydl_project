using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    /// <summary>
    /// 获取比赛场次明细条件
    /// </summary>
    public class GetGameLoopDetailListFilter
    {
        /// <summary>
        /// 场次编号
        /// </summary>
        public string LoopId { get; set; }

        /// <summary>
        /// 场次团队映射编号
        /// </summary>
        public string MapId { get; set; }
    }
}
