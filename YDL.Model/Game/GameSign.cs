using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using YDL.Core;

namespace YDL.Model
{
    /// <summary>
    /// 比赛决赛轮次表
    /// </summary>

    public class GameSign : EntityBase
    {
        /// <summary>
        /// 队伍编号
        /// </summary>
        public string TeamId { get; set; }

        /// <summary>
        /// 队员编号
        /// </summary>
        public string UserId { get; set; }

        /// <summary>
        /// 密码
        /// </summary>
        public string Password { get; set; }
    }
}
