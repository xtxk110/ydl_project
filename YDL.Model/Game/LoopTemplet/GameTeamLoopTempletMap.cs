using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Core;

namespace YDL.Model
{
    /// <summary>
    /// 模板规则与对阵人员映射关系
    /// </summary>
    [Table]
   public  class GameTeamLoopTempletMap:EntityBase
    {
        /// <summary>
        /// 对阵模板ID
        /// </summary>
        [Field]
        public string TempletId { get; set; }
        /// <summary>
        /// 赛事ID
        /// </summary>
        [Field]
        public string GameId { get; set; }
        /// <summary>
        /// 赛事对阵ID
        /// </summary>
        [Field]
        public string LoopId { get; set; }
        /// <summary>
        /// 对阵队伍ID
        /// </summary>
        [Field]
        public string TeamId { get; set; }
        /// <summary>
        /// 模板规则编码字符
        /// </summary>
        [Field]
        public string Code { get; set; }
        /// <summary>
        /// 规则编码字符对应的队员ID
        /// </summary>
        [Field]
        public string CodeUserId { get; set; }
        /// <summary>
        /// 规则编码字符对应的队员姓名(返回时此字段前面附加编码字符,如:A(张三))
        /// </summary>
        [Field]
        public string CodeUserName { get; set; }
        /// <summary>
        /// 是否是主队(队伍1)
        /// </summary>
        [Field]
        public bool IsHost { get; set; }
        /// <summary>
        ///查询返回队伍名称
        /// </summary>
        [Field(IsUpdate =false)]
        public string TeamName { get; set; }


    }
}
