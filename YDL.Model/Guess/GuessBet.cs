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
    /// 竞猜投注
    /// </summary>
    [Table]
    public class GuessBet : EntityBase
    {
        /// <summary>
        /// 竞猜id
        /// </summary>
        [Field]
        public string GuessId { get; set; }

 
        [Field]
        public string UserId { get; set; }

        /// <summary>
        /// 投注的类型
        /// </summary>
        [Field]
        public string BetType { get; set; }
        /// <summary>
        /// 投注的悦豆数
        /// </summary>
        [Field]
        public int Amount { get; set; }

        /// <summary>
        /// 胜负竞猜投注的胜方Id
        /// </summary>
        [Field]
        public string BetVSId { get; set; }

        /// <summary>
        /// 比分竞猜投注的左边分数
        /// </summary>
        [Field]
        public int LeftScore { get; set; }

        /// <summary>
        /// 比分竞猜投注的右边分数
        /// </summary>
        [Field]
        public int RightScore { get; set; }

        /// <summary>
        /// 对阵结果
        /// </summary>
        public string VSResult { get; set; }

        /// <summary>
        /// 对阵详情
        /// </summary>
        public GuessVS GuessVSDetail { get; set; }

        /// <summary>
        /// 投注的赔率(包含比分或胜负)
        /// </summary>
        public decimal BetOdds { get; set; }

        /// <summary>
        /// 猜中或没猜中结果
        /// </summary>
        public string BingoResult { get; set; }
        /// <summary>
        /// 猜中或没猜中结果状态
        /// </summary>
        public string BingoResultState { get; set; }
    }
}
