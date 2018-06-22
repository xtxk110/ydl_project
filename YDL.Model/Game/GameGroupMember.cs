using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;

using YDL.Core;

namespace YDL.Model
{
    /// <summary>
    /// 比赛小组成员分组
    /// </summary>
    [Table]
    public class GameGroupMember : EntityBase
    {
        /// <summary>
        /// 赛事编号
        /// </summary>
        [Field]
        public string GameId { get; set; }

        /// <summary>
        /// 比赛小组
        /// </summary>
        [Field]
        public string GroupId { get; set; }

        /// <summary>
        /// 编号
        /// </summary>
        [Field(dataType: DataType.Int32)]
        public int OrderNo { get; set; }

        /// <summary>
        /// 参赛人/参赛队
        /// </summary>
        [Field]
        public string TeamId { get; set; }

        /// <summary>
        /// 参赛人/参赛队头像
        /// </summary>
        [Field(isUpdate: false)]
        public string TeamHeadUrl { get; set; }

        /// <summary>
        /// 是否团队赛事
        /// </summary>
        [Field(dataType: DataType.Boolean)]
        public bool IsTeam { get; set; }

        /// <summary>
        /// 是否种子
        /// </summary>
        [Field(dataType: DataType.Boolean, isUpdate: false)]
        public bool IsSeed { get; set; }

        /// <summary>
        /// 种子编号
        /// </summary>
        [Field(dataType: DataType.Int32, isUpdate: false)]
        public int SeedNo { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        [Field]
        public string Remark { get; set; }

        /// <summary>
        /// 小组积分
        /// </summary>
        [Field(dataType: DataType.Int32)]
        public int GroupScore { get; set; }

        /// <summary>
        /// 比率
        /// </summary>
        [Field(dataType: DataType.Double)]
        public double Rate { get; set; }

        /// <summary>
        /// 比率备注
        /// </summary>
        [Field]
        public string RateRemark { get; set; }

        /// <summary>
        /// 最终小组排名
        /// </summary>
        [Field(dataType: DataType.Int32)]
        public int Rank { get; set; }

        /// <summary>
        /// 俱乐部档位
        /// </summary>
        [Field(dataType: DataType.Int32, isUpdate: false)]
        public int LevelValue { get; set; }

        /// <summary>
        /// 俱乐部编号
        /// </summary>
        [Field(isUpdate: false)]
        public string ClubId { get; set; }

        /// <summary>
        /// 团队成员编号
        /// </summary>
        [Field(isUpdate: false)]
        public string TeamUserId { get; set; }

        /// <summary>
        /// 团队成员姓名
        /// </summary>
        [Field(isUpdate: false)]
        public string TeamUserName { get; set; }

        /// <summary>
        /// 已经入位
        /// </summary>
        public bool IsEnterPos { get; set; }


        /// <summary>
        /// 计算小组排名辅助字段，请不要使用
        /// </summary>
        [JsonIgnore]
        public double Score { get; set; }

        [JsonIgnore]
        public double WinScore { get; set; }

        [JsonIgnore]
        public double LoseScore { get; set; }

        [JsonIgnore]
        public int Order { get; set; }

        [JsonIgnore]
        public int TotalOrder { get; set; }

        [JsonIgnore]
        public int SameCount { get; set; }
    }
}
