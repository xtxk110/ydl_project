using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Core;
using YDL.Utility;

namespace YDL.Model
{
    /// <summary>
    /// 竞猜
    /// </summary>
    [Table]
    public class Guess : EntityBase
    {
        public Guess()
        {
            ScoreList = new List<GuessScore>();
        }
        /// <summary>
        /// 竞猜名称
        /// </summary>
        [Field]
        public string GuessName { get; set; }

        /// <summary>
        /// 竞猜状态
        /// </summary>
        [Field]
        public string State { get; set; }

        /// <summary>
        /// GameLoop id
        /// </summary>
        [Field]
        public string VsGameLoopId { get; set; }


        /// <summary>
        /// 大轮次编号
        /// </summary>
        [Field]
        public string VsOrderId { get; set; }

        /// <summary>
        /// 淘汰赛为序号，小组赛为轮次
        /// </summary>
        [Field]
        public int VsOrderNo { get; set; }


        /// <summary>
        /// 竞猜类型
        /// </summary>
        [Field]
        public string GuessType { get; set; }

        /// <summary>
        /// 对阵左边Id
        /// </summary>
        [Field]
        public string VSLeftId { get; set; }

        /// <summary>
        /// 对阵左边赔率
        /// </summary>
        [Field]
        public decimal VSLeftOdds { get; set; }

        /// <summary>
        /// 对阵右边Id
        /// </summary>
        [Field]
        public string VsRightId { get; set; }

        /// <summary>
        /// 对阵右边赔率
        /// </summary>
        [Field]
        public decimal VsRightOdds { get; set; }

        /// <summary>
        /// 开始时间
        /// </summary>
        [Field(dataType: DataType.DateTime)]
        public DateTime? BeginTime { get; set; }

        /// <summary>
        /// 结束时间
        /// </summary>
        [Field(dataType: DataType.DateTime)]
        public DateTime? EndTime { get; set; }


        /// <summary>
        /// 胜负庄家押金
        /// </summary>
        [Field]
        public decimal VictoryDefeatDeclarerDeposit { get; set; }

        /// <summary>
        /// 比分庄家押金
        /// </summary>
        [Field]
        public decimal ScoreDeclarerDeposit { get; set; }

        /// <summary>
        /// 对阵详情
        /// </summary>
        public GuessVS GuessVSDetail { get; set; }

        /// <summary>
        /// 比分竞猜的比分列表
        /// </summary>
        public List<GuessScore> ScoreList { get; set; }




        /// <summary>
        /// 创建者名称
        /// </summary>
        [Field(IsUpdate = false)]
        public string CreatorName { get; set; }

        /// <summary>
        /// 胜方id(胜负竞猜)
        /// </summary>
        public string VictoryId { get; set; }

        /// <summary>
        /// 胜方赔率(胜负竞猜)
        /// </summary>
        public decimal VictoryOdds { get; set; }


        /// <summary>
        /// 猜中比分的赔率(比分竞猜)
        /// </summary>
        public decimal BingoScoreOdds { get; set; }

        [Field]
        public string CreatorId { get; set; }


        /// <summary>
        /// 需要支付给猜中方的总悦豆数
        /// </summary>
        public int NeedPayToBingoTotalYueDou { get; set; }

        /// <summary>
        /// 猜中的比分 左边分数
        /// </summary>
        public int BingoLeftScore { get; set; }
        /// <summary>
        /// 猜中的比分 右边分数
        /// </summary>
        public int BingoRightScore { get; set; }

        /// <summary>
        /// 竞猜参与的总人数
        /// </summary>
        public int PersonTotal { get; set; }

        /// <summary>
        /// 竞猜参与的总悦豆
        /// </summary>
        public int YueDouTotal { get; set; }

        /// <summary>
        /// 竞猜规则
        /// </summary>
        public string GuessRule { get { return GuessDic.GuessRule; }}
        
        /// <summary>
        /// 赛事Id
        /// </summary>
        [Field]
        public string GameId { get; set; }
  

    }
}
