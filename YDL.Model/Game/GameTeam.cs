using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using YDL.Core;

namespace YDL.Model
{
    /// <summary>
    /// 比赛参赛人
    /// </summary>
    [Table]
    public class GameTeam : HeadBase
    {
        /// <summary>
        /// 比赛
        /// </summary>
        [Field]
        public string GameId { get; set; }

        /// <summary>
        /// 是否团队比赛
        /// </summary>
        [Field(dataType: DataType.Boolean)]
        public bool IsTeam { get; set; }

        /// <summary>
        /// 是否种子
        /// </summary>
        [Field(dataType: DataType.Boolean)]
        public bool IsSeed { get; set; }

        /// <summary>
        /// 种子编号
        /// </summary>
        [Field(dataType: DataType.Int32)]
        public int SeedNo { get; set; }

        /// <summary>
        /// 队名（团体），姓名（非团体）
        /// </summary>
        [Field]
        public string TeamName { get; set; }

        /// <summary>
        /// 团队成员编号
        /// </summary>
        [Field]
        public string TeamUserId { get; set; }

        /// <summary>
        /// 团队成员姓名
        /// </summary>
        [Field]
        public string TeamUserName { get; set; }

        /// <summary>
        /// 是否支付费用
        /// </summary>
        [Field(dataType: DataType.Boolean)]
        public bool IsPayCost { get; set; }

        /// <summary>
        /// 审核人
        /// </summary>
        [Field]
        public string AuditorId { get; set; }

        /// <summary>
        /// 审核意见
        /// </summary>
        [Field]
        public string AuditRemark { get; set; }

        /// <summary>
        /// 审核日期
        /// </summary>
        [Field]
        public DateTime? AuditDate { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        [Field]
        public string Remark { get; set; }

        /// <summary>
        /// 状态BaseData/GameTeamState
        /// </summary>
        [Field]
        public string State { get; set; }

        /// <summary>
        /// 联系电话
        /// </summary>
        [Field]
        public string MobilePhone { get; set; }

        /// <summary>
        /// 最终排名
        /// </summary>
        [Field(dataType: DataType.Int32, isUpdate: false)]
        public Int64 FinalRank { get; set; }

        /// <summary>
        /// 报名费
        /// </summary>
        [Field(dataType: DataType.Int32, isUpdate: false)]
        public int Cost { get; set; }

        /// <summary>
        /// 积分
        /// </summary>
        [Field(dataType: DataType.Int32, isUpdate: false)]
        public int SportScore { get; set; }

        /// <summary>
        /// 是否实际参加活动（用户群内赛事，确定活动参与者，不一定参加比赛，需要形成活动积分）
        /// </summary>
        [Field(dataType: DataType.Boolean)]
        public bool IsJoined { get; set; }

        /// <summary>
        /// 所属单位
        /// </summary>
        [Field]
        public string CompanyId { get; set; }

        /// <summary>
        /// 创建人
        /// </summary>
        [Field]
        public string CreatorId { get; set; }

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


        public bool IsEnterPos { get; set; }

        /// <summary>
        /// 国家Id
        /// </summary>
        [Field]
        public string NationalId { get; set; }

        /// <summary>
        /// 国旗URL
        /// </summary>
        [Field(isUpdate: false)]
        public string NationalFlagUrl { get; set; }
        /// <summary>
        /// 此赛事此队参赛场次
        /// </summary>
        [Field(IsUpdate =false)]
        public int LoopCount { get; set; }
        /// <summary>
        /// 此赛事此队积分
        /// </summary>
        [Field(IsUpdate =false)]
        public int Score { get; set; }
        /// <summary>
        /// 获取用户详情
        /// </summary>
        public List<TeamDetail> TeamDetail { get; set; }
        /// <summary>
        /// 队伍排名字符
        /// </summary>
        [Field(IsUpdate =false)]
        public string RankStr { get; set; }
        /// <summary>
        /// 针对非团体比赛:非俱乐部比赛,段位;反之,档位
        /// </summary>
        [Field(IsUpdate = false)]
        public string GradeStr { get; set; }

    }
    [Table(name: "UserAccount")]
  public  class TeamDetail:EntityBase
    {
        /// <summary>
        /// 头像地址
        /// </summary>
        [Field]
        public string HeadUrl { get; set; }
        /// <summary>
        /// 姓名
        /// </summary>
        [Field]
        public string CardName { get; set; }
        /// <summary>
        /// 昵称
        /// </summary>
        [Field]
        public string PetName { get; set; }
        /// <summary>
        /// 技能积分
        /// </summary>
        [Field]
        public int SportScore { get; set; }
        /// <summary>
        /// 性别
        /// </summary>
        [Field]
        public string Sex { get; set; }
    }
}
