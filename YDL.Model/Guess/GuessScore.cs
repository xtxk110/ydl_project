using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Core;
using YDL.Utility;

namespace YDL.Model
{
    /// <summary>
    /// 竞猜比分
    /// </summary>
    [Table]
    public class GuessScore : EntityBase
    {
        /// <summary>
        /// 竞猜id
        /// </summary>
        [Field]
        public string GuessId { get; set; }

        /// <summary>
        /// 左边分数
        /// </summary>
        [Field]
        public int LeftScore { get; set; }

        /// <summary>
        /// 右边分数
        /// </summary>
        [Field]
        public int RightScore { get; set; }

        /// <summary>
        /// 赔率
        /// </summary>
        [Field]
        public decimal Odds { get; set; }

        /// <summary>
        /// 猜中比分的总悦豆
        /// </summary>
        public int BingoTotalYueDou { get; set; }

        /// <summary>
        /// 猜中比分的总悦豆百分比
        /// </summary>
        public decimal BingoTotalYueDouPercent { get; set; }

        
        /// <summary>
        /// 是否为最终比分
        /// </summary>
        public bool IsFinalScore { get; set; }

        /// <summary>
        /// 赔率是否为自动计算
        /// </summary>
        [Field]
        public bool IsOddsAuto{ get; set; }
    }
}
