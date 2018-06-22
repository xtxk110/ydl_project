using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Core;

namespace YDL.Model
{
    public  class GameRankFilter:FilterBase
    {
        /// <summary>
        /// 赛事ID
        /// </summary>
        public string GameId { get; set; }
        /// <summary>
        /// 开始大轮次OrderNo
        /// </summary>
        public int StartOrderNo { get; set; }
        /// <summary>
        /// 结束大轮次OrderNo
        /// </summary>
        public int EndOrderNo { get; set; }
    }
}
