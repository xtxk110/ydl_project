using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    public class GuessDic
    {
        #region 竞猜状态

        /// <summary>
        /// 未发布
        /// </summary>
        public const string NotPublish = "NotPublish";

        /// <summary>
        /// 竞猜中
        /// </summary>
        public const string Processing = "Processing";

        /// <summary>
        /// 已结束
        /// </summary>
        public const string Finished = "Finished";

        /// <summary>
        /// 未结算(此状态暂时没什么用)
        /// </summary>
        public const string NotSettlement = "NotSettlement";

        /// <summary>
        /// 已结算
        /// </summary>
        public const string AlreadySettlement = "AlreadySettlement";



        #endregion

        #region 竞猜类型
        /// <summary>
        /// 胜负竞猜
        /// </summary>
        public const string VictoryDefeat = "VictoryDefeat";

        /// <summary>
        /// 比分竞猜
        /// </summary>
        public const string Score = "Score";

        /// <summary>
        /// 胜负比分竞猜
        /// </summary>
        public const string VictoryDefeatAndScore = "VictoryDefeatAndScore";
        #endregion

        /// <summary>
        /// 庄家胜负竞猜坐庄
        /// </summary>
        public const string DeclarerVictoryDefeat = "DeclarerVictoryDefeat";

        /// <summary>
        /// 庄家比分竞猜坐庄
        /// </summary>
        public const string DeclarerScore = "DeclarerScore";


        #region 悦豆消费类型

        /// <summary>
        /// 竞猜投注消费
        /// </summary>
        public const string GuessCost = "GuessCost";
        /// <summary>
        /// 竞猜赚得
        /// </summary>
        public const string GuessEarn = "GuessEarn";
        /// <summary>
        /// 悦豆充值
        /// </summary>
        public const string YueDouTopUp = "YueDouTopUp";
        /// <summary>
        /// 场馆消费
        /// </summary>
        public const string VenueCost = "VenueCost";

        /// <summary>
        /// 场馆赚得
        /// </summary>
        public const string VenueEarn = "VenueEarn";

        /// <summary>
        /// 押金返还
        /// </summary>
        public const string DepositReturn = "DepositReturn";

        #endregion

        #region 猜中结果的状态
        /// <summary>
        /// 猜中
        /// </summary>
        public const string Bingo = "Bingo";
        /// <summary>
        /// 等待结算
        /// </summary>
        public const string WaitSettlement = "WaitSettlement";
        #endregion

        public const string GuessRule = @"
        竞猜参与者：竞猜成功将按比例获取悦豆，获得的悦豆数值为：本金*赔率*（1-10%）；
        竞猜发起者：请务必需要在比赛结束、裁判录入比分之后，点击结算按钮进行竞猜的结算；竞猜发起者可以结束竞猜，或于竞猜结束时间自动结束。
        ";

    }
}
