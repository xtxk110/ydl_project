using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    /// <summary>
    /// 获取竞猜相关的filter
    /// </summary>
    public class GetGuessRelatedFilter : FilterBase
    {
        public GetGuessRelatedFilter()
        {
             
        }
         
        /// <summary>
        /// 竞猜Id
        /// </summary>
        public string GuessId { get; set; }

        /// <summary>
        /// 竞猜名称
        /// </summary>
        public string GuessName { get; set; }

        /// <summary>
        /// 竞猜创建者id
        /// </summary>
        public string CreatorId { get; set; }

        /// <summary>
        /// 竞猜状态
        /// </summary>
        public string State { get; set; }

        /// <summary>
        /// 胜几场
        /// </summary>
        public int WinNumber { get; set; }


        /// <summary>
        /// 比赛id
        /// </summary>
        public string GameId{ get; set; }

    }

}
