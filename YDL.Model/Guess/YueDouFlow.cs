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
    /// 悦豆账单
    /// </summary>
    [Table]
    public class YueDouFlow : EntityBase
    {

        [Field]
        public string UserId { get; set; }

        /// <summary>
        /// 账单类型
        /// </summary>
        [Field]
        public string FlowType { get; set; }

        /// <summary>
        /// 余额
        /// </summary>
        [Field]
        public int Amount { get; set; }

        /// <summary>
        /// 手续费
        /// </summary>
        [Field]
        public decimal ServiceCharge { get; set; }

        /// <summary>
        /// 比赛Id
        /// </summary>
        [Field]
        public string GameId { get; set; }

        /// <summary>
        /// 竞猜Id
        /// </summary>
        [Field]
        public string GuessId { get; set; }

        /// <summary>
        /// 竞猜投注类型
        /// </summary>
        [Field]
        public string GuessBetType { get; set; }
        

    }
}
