using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    /// <summary>
    /// 获取比赛桌子状态条件
    /// </summary>
    public class GetGameTableListFilter
    {
        /// <summary>
        /// 比赛编号
        /// </summary>
        public string GameId { get; set; }

        /// <summary>
        /// 当前时间
        /// </summary>
        public DateTime? CurrentTime { get; set; }
    }
}
