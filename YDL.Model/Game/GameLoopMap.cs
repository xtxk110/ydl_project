using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using YDL.Core;

namespace YDL.Model
{
    /// <summary>
    /// 团队比赛对阵及成绩
    /// </summary>

    [Table]
    public class GameLoopMap : EntityBase
    {
        /// <summary>
        /// 场次
        /// </summary>
        [Field]
        public string LoopId { get; set; }

        /// <summary>
        /// 出场序号
        /// </summary>
        [Field(dataType: DataType.Int32)]
        public int OrderNo { get; set; }

        /// <summary>
        /// 是否团体
        /// </summary>
        [Field(dataType: DataType.Boolean)]
        public bool IsTeam { get; set; }

        /// <summary>
        /// 队员A
        /// </summary>
        [Field]
        public string Team1Id { get; set; }

        /// <summary>
        /// 队员A
        /// </summary>
        [Field]
        public string User1Id { get; set; }

        /// <summary>
        /// 队员A名字
        /// </summary>
        [Field]
        public string User1Name { get; set; }

        /// <summary>
        /// 队员B
        /// </summary>
        [Field]
        public string Team2Id { get; set; }

        /// <summary>
        /// 队员B
        /// </summary>
        [Field]
        public string User2Id { get; set; }

        /// <summary>
        /// 队员B名字
        /// </summary>
        [Field]
        public string User2Name { get; set; }

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
        /// 弃权选项
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
        /// 比赛详情列表
        /// </summary>
        public List<GameLoopDetail> DetailList { get; set; }

        /// <summary>
        /// 保存选项,都保存不设置；保存队伍1为“1”；保存队伍2为“2”
        /// </summary>
        public String SaveMapOption { get; set; }

        /// <summary>
        /// 团队几人胜（用作查询）
        /// </summary>
        [Field(isUpdate: false, dataType: DataType.Int32)]
        public int WinTeam { get; set; }

        /// <summary>
        /// 几局胜
        /// </summary>
        [Field(dataType: DataType.Int32)]
        public int WinGame { get; set; }

        public string User1HeadUrl { get; set; }
        public string User2HeadUrl { get; set; }
        /// <summary>
        /// 队员1技能积分,多个队员积分,以,隔开
        /// </summary>
        public string User1Score { get; set; }
        /// <summary>
        /// 队员2技能积分,多个队员积分,以,隔开
        /// </summary>
        public string User2Score { get; set; }
    }
}
