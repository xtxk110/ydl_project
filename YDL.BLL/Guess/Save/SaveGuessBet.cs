using System;
using System.Linq;
using System.Collections.Generic;

using Newtonsoft.Json;
using YDL.Core;
using YDL.Map;
using YDL.Model;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 保存竞猜投注
    /// </summary>
    public class SaveGuessBet_188 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GuessBet>>(request);
            var guessBet = req.FirstEntity();
            Response rsp = ResultHelper.CreateResponse();
            //检查数据,避免脏数据(BetVSId 和 LeftScore,RightScore 互斥,只存在一种数据)
            if (!string.IsNullOrEmpty(guessBet.BetVSId))
            {
                guessBet.LeftScore = 0;
                guessBet.RightScore = 0;
                guessBet.BetType = GuessDic.VictoryDefeat; //胜负投注
            }
            if (guessBet.LeftScore != 0 && guessBet.RightScore != 0)
            {
                guessBet.BetVSId = "";
                guessBet.BetType = GuessDic.Score; //比分投注
            }

            //判断余额是否够
            if (!GuessHelper.Instance.IsBalanceSufficient(guessBet.UserId, guessBet.Amount))
            {
                return ResultHelper.Fail(ErrorCode.YUEDOU_INSUFFICIENT, "");
            }
            //设置对阵信息(后面好用)
            var guess = GuessHelper.Instance.GetGuess(guessBet.GuessId);
            guess.GuessVSDetail = GuessHelper.Instance.GetVSDetail(guess);
            //检查能否投注
            string errorMsg = CheckCanBetInPool(guess, guessBet);
            if (!string.IsNullOrEmpty(errorMsg))
            {
                return ResultHelper.Fail(errorMsg);
            }

            //扣除余额
            rsp = GuessHelper.Instance.AddOrSubYueDou(-guessBet.Amount, guessBet.UserId);
            if (!rsp.IsSuccess)
            {
                return rsp;
            }
            //插入投注记录
            List<EntityBase> entites = new List<EntityBase>();
            entites.Add(guessBet);

            if (guessBet.RowState == RowState.Added)
            {
                if (!string.IsNullOrEmpty(guessBet.BetVSId))
                {
                    guessBet.BetType = GuessDic.VictoryDefeat;
                }
                else
                {
                    guessBet.BetType = GuessDic.Score;
                }

                guessBet.TrySetNewEntity();
            }

            var result = DbContext.GetInstance().Execute(CommandHelper.CreateSave(entites));
            //插入悦豆消费账单
            if (result.IsSuccess)
            {
                var yueDouFlow = new YueDouFlow();
                yueDouFlow.Amount = -guessBet.Amount;
                yueDouFlow.UserId = guessBet.UserId;
                yueDouFlow.FlowType = GuessDic.GuessCost;
                yueDouFlow.GuessId = guessBet.GuessId;
                result = GuessHelper.Instance.AddYueDouFlow(yueDouFlow);
            }
            return result;
        }


        /// <summary>
        /// 检查在投注池中还能不能投注
        /// 如果投注的悦豆数 超过了最大可投注数, 这样会破坏投注池平衡, 
        ///     导致猜错方的悦豆数无法抵扣猜对方,故用此方法来限制
        /// </summary>
        /// <returns></returns>
        public string CheckCanBetInPool(Guess guess, GuessBet guessBet)
        {
            int maxValue = 0;
            string errorMsg = "";
            maxValue = GetBetCanMaxAmount(guess, guessBet);
            var difference = maxValue - guessBet.Amount;
            if (difference >= 0)
            {
                errorMsg = "";
            }
            else //超过了最大可投注悦豆数
            {
                //将最后一位处理成0,这样就是10的倍数了
                string maxValueStr = "";
                if (maxValue < 10)
                {
                    maxValueStr = "0";
                }
                else
                {
                    maxValueStr = maxValue.ToString();
                    maxValueStr = maxValueStr.Substring(0, maxValueStr.Length - 1) + "0";//把最后一位变为0
                }
                errorMsg = "当前可以投注的最大数量为:[ " + maxValueStr + " ] ,请稍后再投注";
            }
            return errorMsg;
        }


        /// <summary>
        /// 获取可以投注的最大悦豆数 
        /// </summary>
        /// <returns></returns>
        public int GetBetCanMaxAmount(Guess guess, GuessBet guessBet)
        {

            int bingoTotalYuedou = 0;//猜对方总已投 
            int notBingoYuedou = 0;//猜错方悦豆总数
            decimal bingoOdds = 0;//猜对方的赔率
            if (guessBet.BetType == GuessDic.VictoryDefeat)//胜负投注
            {
                //猜对方悦豆总数, 这是用户投注的一方 (默认用户投注的一方都是猜对)
                bingoTotalYuedou = GuessHelper.Instance
                        .GetVictoryOrDefeatTotalYueDou(guess.Id, guessBet.BetVSId);
                //取出对阵失败方的Id
                var defeatVSId = "";
                if (guess.GuessVSDetail.LeftId == guessBet.BetVSId)
                {
                    defeatVSId = guess.GuessVSDetail.RightId;
                }
                else
                {
                    defeatVSId = guess.GuessVSDetail.LeftId;
                }

                //猜错方悦豆总数
                notBingoYuedou = GuessHelper.Instance
                       .GetVictoryOrDefeatTotalYueDou(guess.Id, defeatVSId);
                //猜对方赔率
                if (guess.GuessVSDetail.LeftId == guessBet.BetVSId)
                {
                    bingoOdds = guess.VSLeftOdds;
                }
                else
                {
                    bingoOdds = guess.VsRightOdds;
                }
            }
            else if (guessBet.BetType == GuessDic.Score)//比分投注
            {
                //默认用户投注的比分是猜对的比分
                guess.BingoLeftScore = guessBet.LeftScore;
                guess.BingoRightScore = guessBet.RightScore;
                //猜对方悦豆总数
                bingoTotalYuedou = GuessHelper.Instance
                        .GetBingoScoreTotalYueDou(guess);
                //猜错方悦豆总数
                notBingoYuedou = GuessHelper.Instance
                        .GetNotBingoScoreTotalYueDou(guess);
                //猜对方赔率
                var guessScore = GuessHelper.Instance.GetGuessScore(guess.Id,
                                    guess.BingoLeftScore, guess.BingoRightScore);
                bingoOdds = guessScore.Odds;

            }

            //公式:  可以投的最大悦豆数 =( (猜错方总已投 + 庄家)/ (猜对方赔率-1) ) - 猜对方总已投    注意: 默认用户投的一方都是猜对方
            var notBingoToatal = notBingoYuedou + guess.VictoryDefeatDeclarerDeposit;
            var canBetMaxYueDou = (notBingoToatal / (bingoOdds - 1)) - bingoTotalYuedou;
 
            //如果算出来小于零 ,说明不能投, 就设置为0
            if (canBetMaxYueDou < 0)
            {
                canBetMaxYueDou = 0;
            }

            return Convert.ToInt32(canBetMaxYueDou);

        }





    }

}
