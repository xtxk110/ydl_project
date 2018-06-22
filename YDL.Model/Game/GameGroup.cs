using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using YDL.Core;

namespace YDL.Model
{
    /// <summary>
    /// 比赛分组小组
    /// </summary>
    [Table]
    public class GameGroup : EntityBase
    {
        /// <summary>
        /// 比赛
        /// </summary>
        [Field]
        public string GameId { get; set; }

        /// <summary>
        /// 大轮次
        /// </summary>
        [Field]
        public string OrderId { get; set; }

        /// <summary>
        /// 是否团队赛事
        /// </summary>
        [Field(dataType: DataType.Boolean)]
        public bool IsTeam { get; set; }

        /// <summary>
        /// 序号
        /// </summary>
        [Field(dataType: DataType.Int32)]
        public int OrderNo { get; set; }

        /// <summary>
        /// 名称
        /// </summary>
        [Field]
        public string Name { get; set; }

        /// <summary>
        /// 组长
        /// </summary>
        [Field]
        public string LeaderId { get; set; }

        /// <summary>
        /// 小组使用球桌
        /// </summary>
        [Field]
        public string TableNo { get; set; }

        /// <summary>
        /// 分组成员
        /// </summary>
        public List<GameGroupMember> MemberList { get; set; }

        /// <summary>
        /// 小组比赛
        /// </summary>
        public List<GameLoop> LoopList { get; set; }
    }
}
