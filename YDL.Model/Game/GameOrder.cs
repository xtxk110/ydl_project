using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using YDL.Core;

namespace YDL.Model
{
    /// <summary>
    /// 比赛决赛轮次表
    /// </summary>

    [Table]
    public class GameOrder : EntityBase
    {
        /// <summary>
        /// 比赛编号
        /// </summary>
        [Field]
        public string GameId { get; set; }

        /// <summary>
        /// 前一个
        /// </summary>
        [Field]
        public string PreOrderId { get; set; }

        /// <summary>
        /// A后一轮
        /// </summary>
        [Field]
        public string NextOrderId { get; set; }

        /// <summary>
        /// B后一轮
        /// </summary>
        [Field]
        public string NextOrderBId { get; set; }

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
        /// 序号
        /// </summary>
        [Field(dataType: DataType.Int32)]
        public int OrderNo { get; set; }

        /// <summary>
        /// 是否团队比赛
        /// </summary>
        [Field(dataType: DataType.Boolean)]
        public bool IsTeam { get; set; }

        /// <summary>
        /// 团体小组赛计分模式
        /// </summary>
        [Field]
        public string TeamScoreMode { get; set; }

        /// <summary>
        /// 轮次名次
        /// </summary>
        [Field]
        public string Name { get; set; }

        /// <summary>
        /// 本轮晋级方式，支持单淘汰，单循环两种模式
        /// </summary>
        [Field]
        public string KnockoutOption { get; set; }

        /// <summary>
        /// 晋级名额
        /// </summary>
        [Field(dataType: DataType.Int32)]
        public int KnockoutCount { get; set; }

        /// <summary>
        /// 辅助字段，用于AB组编程
        /// </summary>
        public int KnockoutCountAB { get; set; }

        /// <summary>
        /// 第一轮小组总数
        /// </summary>
        [Field(dataType: DataType.Int32)]
        public int GroupCount { get; set; }

        /// <summary>
        /// 淘汰赛首轮总人数
        /// </summary>
        [Field(dataType: DataType.Int32)]
        public int KnockoutTotal { get; set; }

        /// <summary>
        /// 辅助字段，用于AB组编程
        /// </summary>
        public int KnockoutTotalAB { get; set; }

        /// <summary>
        /// 状态BaseData/GameOrderState
        /// </summary>
        [Field]
        public string State { get; set; }

        /// <summary>
        /// 本轮是否存在附加赛
        /// </summary>
        [Field(dataType: DataType.Boolean)]
        public bool IsExtra { get; set; }

        /// <summary>
        /// 团队几人胜
        /// </summary>
        [Field(dataType: DataType.Int32)]
        public int WinTeam { get; set; }

        /// <summary>
        /// 几局胜
        /// </summary>
        [Field(dataType: DataType.Int32)]
        public int WinGame { get; set; }

        /// <summary>
        /// 淘汰赛AB组类型，小组赛第一轮为空
        /// </summary>
        [Field]
        public string KnockOutAB { get; set; }

        /// <summary>
        /// 决前几名，辅助字段
        /// </summary>
        public int TopNumber { get; set; }

        /// <summary>
        /// 小组分组（按照抽签后顺序）
        /// </summary>
        public List<GameGroup> GroupList { get; set; }

        /// <summary>
        /// 存放抽签位置
        /// </summary>
        public List<GamePosition> PositionList { get; set; }

        /// <summary>
        /// 抽签后种子列表
        /// </summary>
        public List<GamePosition> SeedList { get; set; }

        /// <summary>
        /// 存放每个小组第一名
        /// </summary>
        public List<GameGroupMember> MemberList { get; set; }

        /// <summary>
        /// 是否计算所有位置
        /// </summary>
        public bool CalAllPosition { get; set; }

        /// <summary>
        /// 辅助字段，用于AB组编程
        /// </summary>
        public bool IsKnockOutAB { get; set; }

        /// <summary>
        /// 辅助字段，用于AB组编程
        /// </summary>
        public int BeginRankAB { get; set; }

        /// <summary>
        /// 辅助字段，用于AB组编程
        /// </summary>
        public int EndRankAB { get; set; }

        /// <summary>
        /// 计算总位置
        /// </summary>

        public int ActualCount()
        {
            return GroupCount * KnockoutCountAB;
        }

        /// <summary>
        /// 计算中间位置
        /// </summary>
        public int Middle()
        {
            return KnockoutTotalAB / KnockoutCountAB;
        }

        /// <summary>
        /// 设置AB组选项
        /// </summary>
        /// <param name="isKnockOutAB"></param>
        public void SetKnockOutAB(bool isKnockOutAB)
        {
            IsKnockOutAB = isKnockOutAB;
            if (IsKnockOutAB)
            {
                KnockoutTotalAB = KnockoutTotal / 2;
                KnockoutCountAB = KnockoutCount / 2;
                BeginRankAB = KnockOutAB == YDL.Model.KnockOutAB.A ? 1 : 3;
                EndRankAB = KnockOutAB == YDL.Model.KnockOutAB.A ? 2 : 4;
            }
            else
            {
                KnockoutTotalAB = KnockoutTotal;
                KnockoutCountAB = KnockoutCount;
                BeginRankAB = 1;
                EndRankAB = KnockoutCount;
            }
        }
    }
}
