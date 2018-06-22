using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Core;

namespace YDL.Model
{
    /// <summary>
    /// 团体对阵模板
    /// </summary>
    [Table]
   public class GameTeamLoopTemplet:HeadBase
    {
        /// <summary>
        /// 模板名称,不能重复
        /// </summary>
        [Field]
        public string Name { get; set; }
        [Field]
        public string RuleCode { get; set; }
        /// <summary>
        /// 上场人数
        /// </summary>
        [Field]
        public int PersonCount { get; set; }
        /// <summary>
        /// 总对阵场数
        /// </summary>
        [Field]
        public int LoopCount { get; set; }
        /// <summary>
        /// 模板使用次数
        /// </summary>
        [Field]
        public int UseCount { get; set; }
        /// <summary>
        /// 模板描述
        /// </summary>
        [Field]
        public string Description { get; set; }
        /// <summary>
        /// 模板分享人ID
        /// </summary>
        [Field]
        public string SharePersonId { get; set; }
        /// <summary>
        /// 分享人昵称
        /// </summary>
        [Field(IsUpdate =false)]
        public string SharePerson { get; set; }
        /// <summary>
        /// 是否启用主客队模式
        /// </summary>
        [Field(DataType =DataType.Boolean)]
        public bool IsGuest { get; set; }
        /// <summary>
        /// 模板是否被分享
        /// </summary>
        [Field(DataType = DataType.Boolean)]
        public bool IsShared { get; set; }
        /// <summary>
        /// 是否显示分享开关
        /// </summary>
        [Field(IsUpdate =false, DataType = DataType.Boolean)]
        public bool IsEnableShare { get; set; }
        /// <summary>
        /// 模板是否启用
        /// </summary>
        [Field(DataType = DataType.Boolean)]
        public bool IsEnable { get; set; }
        /// <summary>
        /// 是否是默认模板
        /// </summary>
        [Field(DataType = DataType.Boolean)]
        public bool IsDefault { get; set; }
        /// <summary>
        /// 创建者ID
        /// </summary>
        [Field]
        public string CreatorId { get; set; }
        /// <summary>
        /// 团体对阵模板规则详情
        /// </summary>
        public List<GameTeamLoopTempletDetail> Detail { get; set; }
        /// <summary>
        /// 模板使用提示描述,返回查询使用
        /// </summary>
        public string UseDes { get; set; }
        /// <summary>
        /// 模板规则字符与对阵队员映射关系(只有在设置团体对阵或查看团体对阵时,此值有效),返回查询使用
        /// </summary>
        public List<GameTeamLoopTempletMap> Map { get; set; }
        /// <summary>
        /// 队伍1的规则编码数据(根据模板上场数返回)进入设置对阵时使用
        /// </summary>
        public List<string> Team1Codes { get; set; }
        /// <summary>
        /// 队伍2的规则编码数据(根据模板上场数返回)进入设置对阵时使用
        /// </summary>
        public List<string> Team2Codes { get; set; }
        /// <summary>
        /// 此模板是否被使用
        /// </summary>
        public bool IsUse { get; set; }
    }
}
