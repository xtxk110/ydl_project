using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using YDL.Core;

namespace YDL.Model
{
    /// <summary>
    /// 比赛球桌
    /// </summary>
    [Table]
    public class GameTable : EntityBase
    {
        /// <summary>
        /// 球桌编号
        /// </summary>
        [Field(dataType: DataType.Int32)]
        public int No { get; set; }

        /// <summary>
        /// 是否空闲
        /// </summary>
        [Field(dataType: DataType.Boolean)]
        public bool IsEmpty { get; set; }

    }
}
