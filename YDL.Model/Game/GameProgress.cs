using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using YDL.Core;

namespace YDL.Model
{
    /// <summary>
    /// 比赛进度
    /// </summary>
    [Table]
    public class GameProgress : EntityBase
    {
        /// <summary>
        /// 淘汰赛AB组类型
        /// </summary>
        [Field]
        public string KnockOutAB { get; set; }

        /// <summary>
        /// 轮次编号
        /// </summary>
        [Field]
        public string OrderId { get; set; }

        /// <summary>
        /// 轮次名称
        /// </summary>
        [Field]
        public string OrderName { get; set; }

        /// <summary>
        /// 小组编号
        /// </summary>
        [Field]
        public string GroupId { get; set; }

        /// <summary>
        ///小组名称
        /// </summary>
        [Field]
        public string GroupName { get; set; }

        /// <summary>
        /// 总比赛场数
        /// </summary>
        [Field(dataType: DataType.Int32)]
        public int Total { get; set; }

        /// <summary>
        /// 已完成比赛
        /// </summary>
        [Field(dataType: DataType.Int32)]
        public int Finish { get; set; }

        /// <summary>
        /// 未完成比赛
        /// </summary>
        [Field(dataType: DataType.Int32)]
        public int NotFinish { get; set; }
    }
}
