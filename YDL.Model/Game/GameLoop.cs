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
    /// 小组循环轮次
    /// </summary>
    [Table]
    public class GameLoop : EntityBase
    {
        /// <summary>
        /// 比赛编号
        /// </summary>
        [Field]
        public string GameId { get; set; }

        /// <summary>
        /// 小组编号
        /// </summary>
        [Field]
        public string GroupId { get; set; }

        /// <summary>
        /// 大轮次编号
        /// </summary>
        [Field]
        public string OrderId { get; set; }

        /// <summary>
        /// AB组模式
        /// </summary>
        [Field(isUpdate: false)]
        public string KnockOutAB { get; set; }

        /// <summary>
        /// 轮次名称
        /// </summary>
        [Field(isUpdate: false)]
        public string OrderName { get; set; }

        /// <summary>
        /// 小组名称
        /// </summary>
        [Field(isUpdate: false)]
        public string GroupName { get; set; }

        /// <summary>
        /// 淘汰赛为序号，小组赛为轮次
        /// </summary>
        [Field(dataType: DataType.Int32)]
        public int OrderNo { get; set; }

        /// <summary>
        /// 小组赛每轮次小序号
        /// </summary>
        [Field(dataType: DataType.Int32, onlyInsert: true)]
        public int LoopOrderNo { get; set; }

        /// <summary>
        /// 附加赛标志
        /// </summary>
        [Field(dataType: DataType.Boolean)]
        public bool IsExtra { get; set; }

        /// <summary>
        /// 附加赛虚拟轮次
        /// </summary>
        [Field(dataType: DataType.Int32)]
        public int ExtraOrder { get; set; }

        /// <summary>
        /// 附加赛虚拟胜者轮次
        /// </summary>
        [Field(dataType: DataType.Int32)]
        public int ExtraWinOrder { get; set; }

        /// <summary>
        /// 附加赛虚拟负者轮次
        /// </summary>
        [Field(dataType: DataType.Int32)]
        public int ExtraFailOrder { get; set; }

        /// <summary>
        /// 排名区间开始数
        /// </summary>
        [Field(dataType: DataType.Int32)]
        public int BeginRank { get; set; }

        /// <summary>
        /// 排名区间结束数
        /// </summary>
        [Field(dataType: DataType.Int32)]
        public int EndRank { get; set; }

        /// <summary>
        /// 是否团队比赛
        /// </summary>
        [Field(dataType: DataType.Boolean)]
        public bool IsTeam { get; set; }

        /// <summary>
        /// 团体对证方式
        /// </summary>
        [Field(isUpdate: false)]
        public string TeamMode { get; set; }

        /// <summary>
        /// 队员A
        /// </summary>
        [Field]
        public string Team1Id { get; set; }

        /// <summary>
        /// 队员A头像
        /// </summary>
        [Field(isUpdate: false)]
        public string Team1HeadUrl { get; set; }

        [Field(isUpdate: false)]
        public string Team1CreatorId { get; set; }

        /// <summary>
        /// 队员B
        /// </summary>
        [Field]
        public string Team2Id { get; set; }

        /// <summary>
        /// 队员B头像
        /// </summary>
        [Field(isUpdate: false)]
        public string Team2HeadUrl { get; set; }

        [Field(isUpdate: false)]
        public string Team2CreatorId { get; set; }

        /// <summary>
        /// 球桌编号
        /// </summary>
        [Field(dataType: DataType.Int32)]
        public int TableNo { get; set; }

        /// <summary>
        /// 开始时间
        /// </summary>
        [Field(dataType: DataType.DateTime)]
        public DateTime? BeginTime { get; set; }

        /// <summary>
        /// 实际开始时间
        /// </summary>
        [Field(dataType: DataType.DateTime)]
        public DateTime? StartTime { get; set; }

        /// <summary>
        /// 实际结束时间
        /// </summary>
        [Field(dataType: DataType.DateTime)]
        public DateTime? EndTime { get; set; }

        /// <summary>
        /// 主裁判
        /// </summary>
        [Field]
        public string MasterJudgeId { get; set; }

        /// <summary>
        /// 副裁判
        /// </summary>
        [Field]
        public string JudgeId { get; set; }

        /// <summary>
        /// 得分A
        /// </summary>
        [Field(dataType: DataType.Int32)]
        public int Score1 { get; set; }

        /// <summary>
        /// 得分B
        /// </summary>
        [Field(dataType: DataType.Int32)]
        public int Score2 { get; set; }

        /// <summary>
        /// 团队胜场A（单打比赛默认值1）
        /// </summary>
        [Field(dataType: DataType.Int32)]
        public int Team1 { get; set; }

        /// <summary>
        /// 团队胜场B（单打比赛默认值1）
        /// </summary>
        [Field(dataType: DataType.Int32)]
        public int Team2 { get; set; }

        /// <summary>
        /// 胜局A
        /// </summary>
        [Field(dataType: DataType.Int32)]
        public int Game1 { get; set; }
        /// <summary>
        /// 胜局B
        /// </summary>
        [Field(dataType: DataType.Int32)]
        public int Game2 { get; set; }

        /// <summary>
        /// 小分A
        /// </summary>
        [Field(dataType: DataType.Int32)]
        public int Fen1 { get; set; }

        /// <summary>
        /// 小分B
        /// </summary>
        [Field(dataType: DataType.Int32)]
        public int Fen2 { get; set; }

        /// <summary>
        /// 状态，定义在BaseData/GameLoopState
        /// </summary>
        [Field]
        public string State { get; set; }

        /// <summary>
        /// 是否轮空场次
        /// </summary>
        [Field(dataType: DataType.Boolean)]
        public bool IsBye { get; set; }

        /// <summary>
        /// 弃权选项BaseData/WaiverOption
        /// </summary>
        [Field]
        public string WaiverOption { get; set; }

        /// <summary>
        /// 胜方签名
        /// </summary>
        [Field]
        public string WinSign { get; set; }

        /// <summary>
        /// 裁判签名
        /// </summary>
        [Field]
        public string JudgeSign { get; set; }

        /// <summary>
        /// 抢号赛及对应正式比赛，抢号标记
        /// </summary>
        [Field(dataType: DataType.Boolean)]
        public bool IsKnock { get; set; }

        /// <summary>
        /// 抢号赛对应正式比赛编号
        /// </summary>
        [Field]
        public string KnockLoopId { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        [Field]
        public string Remark { get; set; }

        /// <summary>
        /// 比赛详情
        /// </summary>
        public List<GameLoopDetail> DetailList { get; set; }

        /// <summary>
        /// 团队几人胜（用作查询）
        /// </summary>
        [Field(isUpdate: false, dataType: DataType.Int32)]
        public int WinTeam { get; set; }

        /// <summary>
        /// 几局胜（用作查询）
        /// </summary>
        [Field(isUpdate: false, dataType: DataType.Int32)]
        public int WinGame { get; set; }

        /// <summary>
        /// team1的国旗url
        /// </summary>
        [Field(IsUpdate =false)]
        public string Team1FlagUrl { get; set; }
        /// <summary>
        /// team2的国旗url
        /// </summary>
        [Field(IsUpdate = false)]
        public string Team2FlagUrl { get; set; }
        /// <summary>
        /// 队伍1的组内序号
        /// </summary>
        [Field(IsUpdate =false)]
        public int Team1OrderNo { get; set; }
        /// <summary>
        /// 队伍2的组内序号
        /// </summary>
        [Field(IsUpdate = false)]
        public int Team2OrderNo { get; set; }
    }
}
