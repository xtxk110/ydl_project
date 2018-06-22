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
    /// 竞猜对阵
    /// </summary>
    [Table]
    public class GuessVS : HeadBase
    {
        /// <summary>
        /// 左边的Id
        /// </summary>
        public string LeftId { get; set; }
        /// <summary>
        /// 左边名称
        /// </summary>
        public string LeftName { get; set; }
        /// <summary>
        /// 左边的赔率
        /// </summary>
        public decimal LeftOdds { get; set; }
        /// <summary>
        /// 右边的赔率
        /// </summary>
        public decimal RightOdds { get; set; }

        /// <summary>
        /// 左边名称头像
        /// </summary>
        public string LeftHeadUrl { get; set; }

        /// <summary>
        /// 右边Id
        /// </summary>
        public string RightId { get; set; }
        /// <summary>
        /// 右边名称
        /// </summary>
        public string RightName { get; set; }

        /// <summary>
        /// 右边名称头像
        /// </summary>
        public string RightHeadUrl { get; set; }

        /// <summary>
        /// 左边分数
        /// </summary>
        public int LeftScore { get; set; }

        /// <summary>
        /// 右边分数
        /// </summary>
        public int RightScore { get; set; }

        /// <summary>
        /// 桌号
        /// </summary>
        public int TableNumber { get; set; }

        /// <summary>
        /// 主裁判名称
        /// </summary>
        public string MasterJudgeName { get; set; }

        /// <summary>
        /// 副裁判裁判名称
        /// </summary>
        public string SecondJudgeName { get; set; }

        /// <summary>
        /// 对阵开始时间(也就是比赛开始时间) 
        /// </summary>
        public DateTime? BeginTime { get; set; }

        /// <summary>
        /// 对阵状态
        /// </summary>
        public string State { get; set; }

        /// <summary>
        /// 胜方id(胜负竞猜)
        /// </summary>
        public string VictoryId { get; set; }

        /// <summary>
        /// 胜方赔率(胜负竞猜)
        /// </summary>
        public decimal VictoryOdds { get; set; }
        /// <summary>
        /// 胜方的总悦豆(胜负竞猜)
        /// </summary>
        public int VictoryTotalYueDou { get; set; }

        /// <summary>
        /// 胜方的总悦豆百分比(胜负竞猜)
        /// </summary>
        public decimal VictoryTotalYueDouPercent { get; set; }

        /// <summary>
        /// 比赛的Id
        /// </summary>
        public string GameId { get; set; }

        /// <summary>
        /// 几打几胜(比如3表示 5打3胜)
        /// </summary>
        [Field]
        public int WinNumber { get; set; }
    }
}
