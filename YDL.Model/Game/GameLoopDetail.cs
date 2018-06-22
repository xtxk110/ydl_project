using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using YDL.Core;

namespace YDL.Model
{
    /// <summary>
    /// 小组循环比赛每场详情
    /// </summary>
    [Table]
    public class GameLoopDetail : EntityBase
    {
        /// <summary>
        /// 场次
        /// </summary>
        [Field]
        public string LoopId { get; set; }

        /// <summary>
        /// 队员映射编号
        /// </summary>
        [Field]
        public string MapId { get; set; }

        /// <summary>
        /// 是否团队赛事
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

        public string User1HeadUrl { get; set; }
       
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
        public string User2HeadUrl { get; set; }

        /// <summary>
        /// 局编号
        /// </summary>
        [Field(dataType: DataType.Int32)]
        public int OrderNo { get; set; }

        /// <summary>
        /// 得分A
        /// </summary>
        [Field(dataType: DataType.Int32)]
        public int Fen1 { get; set; }

        /// <summary>
        /// 得分B
        /// </summary>
        [Field(dataType: DataType.Int32)]
        public int Fen2 { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public string OrderId { get; set; }

        /// <summary>
        /// 1参赛者默认加几分(即2参赛者让1参赛者多少)
        /// </summary>
        [Field(dataType: DataType.Int32, isUpdate: false)]
        public int ConcessionScore1 { get; set; }
        /// <summary>
        /// 2参赛者默认加几分(即1参赛者让2参赛者多少)
        /// </summary>
        [Field(dataType: DataType.Int32, isUpdate: false)]
        public int ConcessionScore2 { get; set; }
        /// <summary>
        /// 比赛对阵的胜局
        /// </summary>
        [Field(dataType: DataType.Int32, isUpdate: false)]
        public int WinGame { get; set; }
        ///// <summary>
        ///// 队员1技能积分,多个队员积分,以,隔开
        ///// </summary>
        //public string User1Score { get; set; }
        ///// <summary>
        ///// 队员2技能积分,多个队员积分,以,隔开
        ///// </summary>
        //public string User2Score { get; set; }
    }
}
