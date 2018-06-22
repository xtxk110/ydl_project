using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Core;

namespace YDL.Model
{
    /// <summary>
    /// 某赛事参赛队员个人技能积分排名
    /// </summary>
    [Table(name: "UserAccount")]
    public class GamePersonaRank:HeadBase
    {
        /// <summary>
        /// 姓名
        /// </summary>
        [Field]
        public string Name { get; set; }
        /// <summary>
        /// 此赛事获取的技能积分,可为负
        /// </summary>
        [Field]
        public int Score { get; set; }
        /// <summary>
        /// 根据技能积分的最终排名
        /// </summary>
        [Field]
        public Int64 FinalRank { get; set; }

    }
}
