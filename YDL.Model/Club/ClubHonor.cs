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
    /// 俱乐部荣誉等级
    /// </summary>
    [Table]
    public class ClubHonor : EntityBase
    {
        /// <summary>
        /// 顺序号
        /// </summary>
        [Field(dataType: DataType.Int32)]
        public int SortIndex { get; set; }

        /// <summary>
        /// 名称
        /// </summary>
        [Field]
        public string Name { get; set; }

        /// <summary>
        /// 俱乐部
        /// </summary>
        [Field]
        public string ClubId { get; set; }

        /// <summary>
        /// 开始积分
        /// </summary>
        [Field(dataType: DataType.Int32)]
        public int BeginScore { get; set; }

        /// <summary>
        /// 截止积分
        /// </summary>
        [Field(dataType: DataType.Int32)]
        public int EndScore { get; set; }
    }
}
