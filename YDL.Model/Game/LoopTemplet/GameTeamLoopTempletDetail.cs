using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Core;

namespace YDL.Model
{
    /// <summary>
    /// 团体对阵模板规则详情
    /// </summary>
    [Table]
   public  class GameTeamLoopTempletDetail:EntityBase
    {
        /// <summary>
        /// 对阵模板ID
        /// </summary>
        [Field]
        public string  TempletId { get; set; }
        /// <summary>
        /// 规则次序(对应对阵的出场顺序)
        /// </summary>
        [Field]
        public int OrderNo { get; set; }
        /// <summary>
        /// 队伍1对阵编码(启用了主客队,则为客队对阵编码) (沟通取消拼接)返回时此字段后面附加队员名称,如:A(张三);假如双打,如:A(张三),B(李四)
        /// </summary>
        [Field]
        public string Code1 { get; set; }
        /// <summary>
        /// 队伍2对阵编码(启用了主客队,则为客队对阵编码) (沟通取消拼接)返回时此字段后面附加队员名称,如:W(张三);假如双打,如:W(张三),X(李四)
        /// </summary>
        [Field]
        public string Code2 { get; set; }
        /// <summary>
        /// 是否是双打
        /// </summary>
        [Field(dataType:DataType.Boolean)]
        public bool IsDouble { get; set; }
        /// <summary>
        /// 队伍1队员名称(双打,以逗号隔开返回,顺序与双打编码字符相同),返回查询使用
        /// </summary>
        [Field(IsUpdate = false)]
        public string User1Name { get; set; }
        /// <summary>
        /// 队伍1队员ID(双打,以逗号隔开返回,顺序与双打编码字符相同),返回查询使用
        /// </summary>
        [Field(IsUpdate = false)]
        public string User1Id { get; set; }
        /// <summary>
        /// 队伍2队员名称(双打,以逗号隔开返回,顺序与双打编码字符相同),返回查询使用
        /// </summary>
        [Field(IsUpdate =false)]
        public string User2Name { get; set; }
        /// <summary>
        /// 队伍2队员ID(双打,以逗号隔开返回,顺序与双打编码字符相同),返回查询使用
        /// </summary>
        [Field(IsUpdate = false)]
        public string User2Id { get; set; }

    }
}
