using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using YDL.Core;

namespace YDL.Model
{
    /// <summary>
    /// 比赛
    /// </summary>
    [Table]
    public class Game : HeadBase
    {
        /// <summary>
        /// 是否置顶
        /// </summary>
        [Field(dataType: DataType.Boolean)]
        public bool IsTop { get; set; }

        /// <summary>
        /// 运动类别
        /// </summary>
        [Field]
        public string SportId { get; set; }

        /// <summary>
        /// 活动编号
        /// </summary>
        [Field]
        public string ActivityId { get; set; }

        /// <summary>
        /// 名称
        /// </summary>
        [Field]
        public string Name { get; set; }

        /// <summary>
        /// 参与人显示名称选项
        /// </summary>
        [Field]
        public string NameOption { get; set; }

        /// <summary>
        /// 介绍
        /// </summary>
        [Field]
        public string Introduce { get; set; }

        /// <summary>
        /// 奖品
        /// </summary>
        [Field]
        public string Prize { get; set; }

        /// <summary>
        /// 规则
        /// </summary>
        [Field]
        public string GameRule { get; set; }

        /// <summary>
        /// 俱乐部
        /// </summary>
        [Field]
        public string ClubId { get; set; }

        /// <summary>
        /// 团队选项（男单，男双，女单，女双，混双，男团，女团，混合团）
        /// </summary>
        [Field]
        public string BattleStyle { get; set; }

        /// <summary>
        /// 单项比赛人数，团体设为0
        /// </summary>
        [Field]
        public int BattleStyleCount { get; set; }

        /// <summary>
        /// 比赛晋级方式，支持单淘汰，小组循环后淘汰两种模式
        /// </summary>
        [Field]
        public string KnockoutOption { get; set; }

        /// <summary>
        /// 第二阶段淘汰赛启用AB组
        /// </summary>
        [Field(dataType: DataType.Boolean)]
        public bool IsKnockOutAB { get; set; }

        /// <summary>
        /// 辅助字段，用于查询名次AB组
        /// </summary>
        public string KnockOutAB { get; set; }

        /// <summary>
        /// 是否档位赛
        /// </summary>
        [Field(dataType: DataType.Boolean)]
        public bool IsLevelGame { get; set; }

        /// <summary>
        /// 档位（档位比赛）
        /// </summary>
        [Field(dataType: DataType.Int32)]
        public int LevelValue { get; set; }

        /// <summary>
        /// 俱乐部档位
        /// </summary>
        [Field(dataType: DataType.Int32, isUpdate: false)]
        public int ClubLevelValue { get; set; }

        /// <summary>
        /// 团队比赛模式BaseData/TeamMode
        /// </summary>
        [Field]
        public string TeamMode { get; set; }

        /// <summary>
        /// 是否团队赛事
        /// </summary>
        [Field(dataType: DataType.Boolean)]
        public bool IsTeam { get; set; }

        /// <summary>
        /// 是否积分赛
        /// </summary>
        [Field(dataType: DataType.Boolean)]
        public bool IsScoreGame { get; set; }

        /// <summary>
        /// 开始积分
        /// </summary>
        [Field(dataType: DataType.Int32)]
        public int BeginScore { get; set; }

        /// <summary>
        /// 结束积分
        /// </summary>
        [Field(dataType: DataType.Int32)]
        public int EndScore { get; set; }

        /// <summary>
        /// 场地
        /// </summary>
        [Field]
        public string VenueId { get; set; }

        /// <summary>
        /// 详细地址
        /// </summary>
        [Field(isUpdate: false)]
        public string VenueAddress { get; set; }

        /// <summary>
        /// 报名费
        /// </summary>
        [Field(dataType: DataType.Int32)]
        public int Cost { get; set; }

        /// <summary>
        /// 主办单位
        /// </summary>
        [Field]
        public string Organizer { get; set; }

        /// <summary>
        /// 承办单位
        /// </summary>
        [Field]
        public string SecondOrganizer { get; set; }

        /// <summary>
        /// 报名开始时间
        /// </summary>
        [Field(dataType: DataType.DateTime)]
        public DateTime RegBeginTime { get; set; }

        /// <summary>
        /// 报名截止时间
        /// </summary>
        [Field(dataType: DataType.DateTime)]
        public DateTime RegEndTime { get; set; }

        /// <summary>
        /// 比赛开始时间
        /// </summary>
        [Field(dataType: DataType.DateTime)]
        public DateTime PlayBeginTime { get; set; }

        /// <summary>
        /// 比赛结束时间
        /// </summary>
        [Field(dataType: DataType.DateTime)]
        public DateTime PlayEndTime { get; set; }

        /// <summary>
        /// 创建人
        /// </summary>
        [Field(onlyInsert: true)]
        public string CreatorId { get; set; }

        /// <summary>
        /// 创建人手机
        /// </summary>
        [Field(isUpdate: false)]
        public string CreatorMobile { get; set; }

        /// <summary>
        /// 状态BaseData/GameState
        /// </summary>
        [Field]
        public string State { get; set; }

        /// <summary>
        /// 城市
        /// </summary>
        [Field]
        public string CityId { get; set; }

        /// <summary>
        /// 查询辅助字段，当前用户是否是比赛成员
        /// </summary>
        [Field(isUpdate: false, dataType: DataType.Int32)]
        public int IsGameJoined { get; set; }

        /// <summary>
        /// 查询辅助字段，当前用户是否是俱乐部成员
        /// </summary>
        [Field(isUpdate: false, dataType: DataType.Int32)]
        public int IsClubJoined { get; set; }

        /// <summary>
        /// 查询辅助字段，参赛队伍总数
        /// </summary>
        [Field(isUpdate: false, dataType: DataType.Int32)]
        public int TeamCount { get; set; }

        /// <summary>
        /// 查询辅助字段，当前人昵称
        /// </summary>
        [Field(isUpdate: false)]
        public string CurrentPetName { get; set; }

        /// <summary>
        /// 查询辅助字段，回复数
        /// </summary>
        [Field(dataType: DataType.Int32, isUpdate: false)]
        public int ReplyCount { get; set; }

        /// <summary>
        /// 查询辅助字段，用于详情页面快捷队伍头像显示，默认返回10个
        /// </summary>
        public List<GameTeam> GameTeamList { get; set; }

        /// <summary>
        /// 是否启用赛事tv展示
        /// </summary>
        [Field]
        public bool IsEnableTV { get; set; }
        /// <summary>
        /// 是否启用APP直播比分显示
        /// </summary>
        [Field]
        public bool IsEnableLiveScore { get; set; }

        /// <summary>
        /// 赛事TVSocket服务器的Ip和端口
        /// </summary>
        
        public string SocketIpAndPort { get; set; }


        /// <summary>
        /// 是否启用让分
        /// </summary>
        [Field]
        public bool IsConcessionScore { get; set; }

        /// <summary>
        /// 是否处于直播中
        /// </summary>
        public bool IsInLive { get; set; }
        /// <summary>
        /// 赛事审核员用户ID,多个以逗号隔开
        /// </summary>
        [Field]
        public string AuditId { get; set; }
        /// <summary>
        /// 赛事审核员用户名称,多个以逗号隔开
        /// </summary>
        public string AuditName { get; set; }
        /// <summary>
        /// 赛事管理员用户ID,,多个以逗号隔开
        /// </summary>
        [Field]
        public string ManageId { get; set; }
        /// <summary>
        /// 赛事管理员用户名称,多个以逗号隔开
        /// </summary>
        public string ManageName { get; set; }
        /// <summary>
        /// 是否是此赛事的审核员
        /// </summary>
        public bool IsAudit { get; set; }
        
        /// <summary>
        /// 是否是此赛事的管理员
        /// </summary>
        public bool IsManage { get; set; }
        /// <summary>
        /// 是否启用联赛模式(单循环才此操作)
        /// </summary>
        [Field(dataType:DataType.Boolean)]
        public bool IsLeague { get; set; }
        /// <summary>
        /// 规则模板对应的对阵胜场数(针对团体赛有效)
        /// </summary>
        [Field(IsUpdate =false)]
        public int WinLoopCount { get; set; }
        /// <summary>
        /// 对阵小局胜局数
        /// </summary>
        public int[] WinGameArr { get; set; }
        /// <summary>
        /// 所选赛事的审核员列表
        /// </summary>
        //public List<SelectedUser> AuditdList { get; set; }
        /// <summary>
        /// 所选赛事的管理员列表
        /// </summary>
        //public List<SelectedUser> ManagedList { get; set; }
    }
    [Table(name: "UserAccount")]
    public class SelectedUser : HeadBase
    {
        /// <summary>
        /// 编号
        /// </summary>
        [Field]
        public string Code { get; set; }

        /// <summary>
        /// 名称
        /// </summary>
        [Field]
        public string PetName { get; set; }
        /// <summary>
        /// 姓名
        /// </summary>
        [Field]
        public string CardName { get; set; }

        /// <summary>
        /// 性别
        /// </summary>
        [Field]
        public string Sex { get; set; }
    }
}
