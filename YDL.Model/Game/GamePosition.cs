using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using YDL.Core;

namespace YDL.Model
{
    public class GamePosition : EntityBase
    {
        /// <summary>
        /// 序号
        /// </summary>
        public int Index { get; set; }

        /// <summary>
        /// 第一名位置
        /// </summary>
        public bool IsSeed { get; set; }

        /// <summary>
        /// 队伍
        /// </summary>
        public string UserId { get; set; }

        /// <summary>
        /// 小组
        /// </summary>
        public string GroupId { get; set; }

        /// <summary>
        /// 小组排名
        /// </summary>
        public int Rank { get; set; }

        /// <summary>
        /// 抢号人
        /// </summary>
        public string KnockUserId { get; set; }

        /// <summary>
        /// 轮空位
        /// </summary>
        public bool IsBye { get; set; }
    }
}
