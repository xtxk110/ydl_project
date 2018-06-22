using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Core;

namespace YDL.Model
{
    /// <summary>
    /// 某专长比赛的轮次
    /// </summary>
    [Table(name:"GameLoop")]
   public class GameLoopOrderNo:EntityBase
    {
        /// <summary>
        /// 比赛的轮次序号
        /// </summary>
        [Field]
        public int OrderNo { get; set; }
    }
}
