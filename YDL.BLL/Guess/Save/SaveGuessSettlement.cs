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
    /// 保存竞猜结算
    /// </summary>
    public class SaveGuessSettlement_188 : IServiceBase
    {
        private string notPayMsg = "猜错方的悦豆总数无法支付给猜对方, 无法结算, 请联系悦动力";
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<Guess>>(request);
            var obj = req.FirstEntity();
            Response rsp = ResultHelper.CreateResponse();
            //获取竞猜详情
            var guess = GuessHelper.Instance.GetGuess(obj.Id);
            //已经结算了的不能再结算
            if (guess.State == GuessDic.AlreadySettlement)
            {
                return ResultHelper.Fail("已经结算了的不能再结算");
            }
            //获取对阵信息
            var guessVS = GuessHelper.Instance.GetVSDetail(guess);
            guess.GuessVSDetail = guessVS;
            //对阵结束了才能结算
            if (guessVS.State != GameLoopState.FINISH.Id)
            {
                return ResultHelper.Fail("对阵比赛结束了才能结算");
            }

            //判断猜错方的总悦豆能否抵扣猜对方的

            string errorMsg = "";

            //胜负竞猜
            if (guess.GuessType == GuessDic.VictoryDefeat)
            {
                errorMsg = CheckCanPayBingoInVictoryDefeat(guess);
                if (!string.IsNullOrEmpty(errorMsg))
                {
                    return ResultHelper.Fail(errorMsg);
                }
                rsp = VictoryDefeatSettlement(guess, guessVS);
            }
            //比分竞猜
            if (guess.GuessType == GuessDic.Score)
            {
                errorMsg = CheckCanPayBingoInScore(guess);
                if (!string.IsNullOrEmpty(errorMsg))
                {
                    return ResultHelper.Fail(errorMsg);
                }
                rsp = ScoreSettlement(guess, guessVS);
            }

            //胜负比分竞猜
            if (guess.GuessType == GuessDic.VictoryDefeatAndScore)
            {
                errorMsg = CheckCanPayBingoInVictoryDefeat(guess);
                if (!string.IsNullOrEmpty(errorMsg))
                {
                    return ResultHelper.Fail(errorMsg);
                }
                rsp = VictoryDefeatSettlement(guess, guessVS);
                if (rsp.IsSuccess)
                {
                    errorMsg = CheckCanPayBingoInScore(guess);
                    if (!string.IsNullOrEmpty(errorMsg))
                    {
                        return ResultHelper.Fail(errorMsg);
                    }
                    rsp = ScoreSettlement(guess, guessVS);
                }
            }

            //修改竞猜状态为已结算
            if (rsp.IsSuccess)
            {
                rsp = UpdateGuess(guess.Id);
            }
            if (!rsp.IsSuccess)
            {
                throw new Exception("出错了");
            }

            return rsp;
        }

        /// <summary>
        /// 判断比分竞猜中猜对方的悦豆能否支付
        /// 即: 庄家+猜错方总悦豆 >= 猜对方总悦豆*(猜对方赔率-1) , 如果猜错方的总悦豆都不能抵扣猜对方的, 
        ///         那么就需要ydl来填差的悦豆, 老板说我们不吃这个亏
        /// </summary>
        /// <returns></returns>
        public string CheckCanPayBingoInScore(Guess guess)
        {
            int bingoYuedou = 0;//猜对方悦豆总数
            int notBingoYuedou = 0;//猜错方悦豆总数
            decimal bingoOdds = 0;//猜对方的赔率
            GuessHelper.Instance.SetBingoScoreAndOdds(guess, guess.GuessVSDetail);
            //猜对方悦豆总数
            bingoYuedou = GuessHelper.Instance
                    .GetBingoScoreTotalYueDou(guess);
            //猜错方悦豆总数
            notBingoYuedou = GuessHelper.Instance
                    .GetNotBingoScoreTotalYueDou(guess);
            //猜对方赔率
            var guessScore = GuessHelper.Instance.GetGuessScore(guess.Id,
                                guess.BingoLeftScore, guess.BingoRightScore);
            bingoOdds = guessScore.Odds;


            //公式:  庄家+猜错方总悦豆 >= 猜对方总悦豆*(猜对方赔率-1) 
            var notBingoToatal = notBingoYuedou + guess.VictoryDefeatDeclarerDeposit;
            var bingoTotal = bingoYuedou * (bingoOdds - 1);
            if (notBingoToatal >= bingoTotal)
            {
                return "";
            }
            else
            {
                return notPayMsg;
            }


        }

        /// <summary>
        /// 判断胜负竞猜中猜对方的悦豆能否支付
        /// 即: 庄家+猜错方总悦豆 >= 猜对方总悦豆*(猜对方赔率-1) , 如果猜错方的总悦豆都不能抵扣猜对方的, 
        ///         那么就需要ydl来填差的悦豆, 老板说我们不吃这个亏
        /// </summary>
        /// <returns></returns>
        public string CheckCanPayBingoInVictoryDefeat(Guess guess)
        {
            int bingoYuedou = 0;//猜对方悦豆总数
            int notBingoYuedou = 0;//猜错方悦豆总数
            decimal bingoOdds = 0;//猜对方的赔率
            GuessHelper.Instance.SetVictoryIdAndOdds(guess, guess.GuessVSDetail);
            //猜对方悦豆总数
            bingoYuedou = GuessHelper.Instance
                    .GetVictoryOrDefeatTotalYueDou(guess.Id, guess.VictoryId);
            //取出对阵失败方的Id
            var defeatVSId = "";
            if (guess.GuessVSDetail.LeftId == guess.VictoryId)
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
            if (guess.GuessVSDetail.LeftId == guess.VictoryId)
            {
                bingoOdds = guess.VSLeftOdds;
            }
            else
            {
                bingoOdds = guess.VsRightOdds;
            }

            //公式:  庄家+猜错方总悦豆 >= 猜对方总悦豆*(猜对方赔率-1) 
            var notBingoToatal = notBingoYuedou + guess.VictoryDefeatDeclarerDeposit;
            var bingoTotal = bingoYuedou * (bingoOdds - 1);
            if (notBingoToatal >= bingoTotal)
            {
                return "";
            }
            else
            {
                return notPayMsg;
            }

        }

        /// <summary>
        /// 胜负竞猜结算
        /// </summary>
        /// <param name="guess"></param>
        public Response VictoryDefeatSettlement(Guess guess, GuessVS guessVS)
        {
            Response rsp = ResultHelper.CreateResponse();
            //取出胜方的Id和赔率, 赋到guess 实体上
            GuessHelper.Instance.SetVictoryIdAndOdds(guess, guessVS);
            //查出胜方用户列表, 进行返钱
            var victoryBetList = GetGuessVictoryDefeatBetList(guess.VictoryId, guess.Id);
            if (victoryBetList.Count > 0)
            {
                rsp = BackYueDouToUser(victoryBetList, guess, guess.VictoryOdds);

            }
            //增减庄家的悦豆
            var totalYuedou = GuessHelper.Instance.GetGuessTotalYueDouByType(guess.Id, GuessDic.VictoryDefeat);//胜负投注的总悦豆
            var bingoTotalYueDou = GuessHelper.Instance.GetVictoryOrDefeatTotalYueDou(guess.Id, guess.VictoryId);//胜方总悦豆
            var declareDeposit = Convert.ToInt32(guess.VictoryDefeatDeclarerDeposit);
            rsp = AddOrSubDeclarerYueDou(guess, totalYuedou
                , bingoTotalYueDou, declareDeposit, GuessDic.DeclarerVictoryDefeat);
            SystemHelper.CheckResponseIfError(rsp);
            return rsp;
        }


        /// <summary>
        /// 比分竞猜结算
        /// </summary>
        /// <param name="guess"></param>
        public Response ScoreSettlement(Guess guess, GuessVS guessVS)
        {
            Response rsp = ResultHelper.CreateResponse();
            //取出猜中的比分和赔率, 赋到guess 实体上
            GuessHelper.Instance.SetBingoScoreAndOdds(guess, guessVS);
            //查出胜方用户列表, 进行返钱
            var bingoBetList = GetGuessScoreBetList(guess);
            if (bingoBetList.Count > 0)
            {
                rsp = BackYueDouToUser(bingoBetList, guess, guess.BingoScoreOdds);
            }
            //增减庄家的悦豆
            var totalYuedou = GuessHelper.Instance.GetGuessTotalYueDouByType(guess.Id, GuessDic.Score);//比分投注的总悦豆
            var bingoTotalYueDou = GuessHelper.Instance.GetBingoScoreTotalYueDou(guess);//猜中比分的总悦豆
            var declareDeposit = Convert.ToInt32(guess.ScoreDeclarerDeposit);
            rsp = AddOrSubDeclarerYueDou(guess, totalYuedou
                , bingoTotalYueDou, declareDeposit, GuessDic.DeclarerScore);
            SystemHelper.CheckResponseIfError(rsp);
            return rsp;

        }

        /// <summary>
        /// 增减庄家的悦豆
        /// 业务逻辑: 
        /// 如果输的一方全部陪给赢的一方, 钱还不够, 就从庄家哪里扣.  
        /// 如果输的一方赔完了,输的那方还有剩, 就把这剩的钱给庄家. 
        /// </summary>
        /// <param name="guess"></param>
        /// <param name="totalYuedou"></param>
        /// <param name="bingoTotalYueDou"></param>
        /// <param name="declarerDeposit">庄家的钱</param>
        /// <returns></returns>
        public Response AddOrSubDeclarerYueDou(Guess guess, int totalYuedou
            , int bingoTotalYueDou, int declarerDeposit, string betType)
        {
            Response rsp = ResultHelper.CreateResponse();
            //悦豆账单实体
            var yueDouFlow = new YueDouFlow();
            yueDouFlow.UserId = guess.CreatorId;
            yueDouFlow.FlowType = GuessDic.GuessEarn;
            yueDouFlow.GameId = guess.GuessVSDetail.GameId;
            yueDouFlow.GuessId = guess.Id;
            yueDouFlow.GuessBetType = betType;

            var defeatTotal = totalYuedou - bingoTotalYueDou;//输方总悦豆
            var differenceValue = defeatTotal - guess.NeedPayToBingoTotalYueDou; //用输方的钱来支付, 看是余还是差
            if (differenceValue == 0) //刚好够,庄家的钱不扣, 本金原路返回到他的账户
            {
                //返还悦豆
                rsp = GuessHelper.Instance.AddOrSubYueDou(declarerDeposit, guess.CreatorId);
                //记录账单
                yueDouFlow.Amount = declarerDeposit;
                rsp = GuessHelper.Instance.AddYueDouFlow(yueDouFlow);
            }
            else if (differenceValue > 0)//有余, 就将余下的钱返给庄家(含本金), 返前扣除手续费
            {
                //返还悦豆
                var serviceCharge = differenceValue * (UserHelper.GetConfig().GuessServiceCharge / 100);//手续费
                var earnValueDecimal = differenceValue - serviceCharge;
                var earnYueDou = Convert.ToInt32(earnValueDecimal);
                var amount = declarerDeposit + earnYueDou;//本金+赚得的
                rsp = GuessHelper.Instance.AddOrSubYueDou(amount, guess.CreatorId);
                //记录账单
                yueDouFlow.Amount = amount;
                yueDouFlow.ServiceCharge = serviceCharge;
                rsp = GuessHelper.Instance.AddYueDouFlow(yueDouFlow);

            }
            else if (differenceValue < 0)//不够,就从庄家押金里面扣, 将剩余的再返给庄家账户
            {
                var restOfValueDecimal = declarerDeposit + differenceValue;
                if (restOfValueDecimal > 0)
                {
                    var restOfValue = Convert.ToInt32(restOfValueDecimal);
                    rsp = GuessHelper.Instance.AddOrSubYueDou(restOfValue, guess.CreatorId);
                    //记录账单
                    yueDouFlow.Amount = restOfValue;
                    rsp = GuessHelper.Instance.AddYueDouFlow(yueDouFlow);
                }
            }

            SystemHelper.CheckResponseIfError(rsp);
            return rsp;
        }



        /// <summary>
        /// 返悦豆给用户
        /// </summary>
        /// <param name="bingoBetList"></param>
        /// <param name="guess"></param>
        /// <param name="odds">赔率</param>
        /// <returns></returns>
        public Response BackYueDouToUser(List<GuessBet> bingoBetList, Guess guess, decimal odds)
        {
            Response rsp = ResultHelper.CreateResponse();
            int NeedPayToBingoTotalYueDou = 0;
            foreach (var item in bingoBetList)
            {
                var earnYueDou = item.Amount * (odds - 1);//赚得的悦豆
                var serviceChargeDecimal = earnYueDou * (UserHelper.GetConfig().GuessServiceCharge / 100);//手续费
                int serviceCharge = Convert.ToInt32(serviceChargeDecimal);//舍弃小数位,少收点手续费
                decimal finalEarn = earnYueDou - serviceCharge;//最后赚的
                var returnYuedouTotalDecimal = item.Amount + finalEarn;   //返回的总悦豆=本金+最后赚得
                int returnYuedouTotal = Convert.ToInt32(returnYuedouTotalDecimal);//返回的总悦豆,舍弃小数位
                //返还悦豆给此用户
                rsp = GuessHelper.Instance.AddOrSubYueDou(returnYuedouTotal, item.UserId);
                SystemHelper.CheckResponseIfError(rsp);

                //保存此用户的悦豆账单(含手续费数据)
                var yueDouFlow = new YueDouFlow();
                yueDouFlow.Amount = returnYuedouTotal;//返回的总悦豆-本金=赚的
                yueDouFlow.UserId = item.UserId;
                yueDouFlow.FlowType = GuessDic.GuessEarn;
                yueDouFlow.ServiceCharge = serviceCharge;
                yueDouFlow.GameId = guess.GuessVSDetail.GameId;
                yueDouFlow.GuessId = guess.Id;
                rsp = GuessHelper.Instance.AddYueDouFlow(yueDouFlow);
                SystemHelper.CheckResponseIfError(rsp);

                //累计需要支付的总悦豆
                NeedPayToBingoTotalYueDou += Convert.ToInt32(earnYueDou);
            }
            rsp.IsSuccess = true;
            guess.NeedPayToBingoTotalYueDou = NeedPayToBingoTotalYueDou;

            return rsp;
        }



        private List<GuessBet> GetGuessScoreBetList(Guess guess)
        {
            var sql = @"

SELECT * 
FROM dbo.GuessBet 
WHERE  
      GuessId=@GuessId
	  AND LeftScore=@LeftScore
	  AND RightScore=@RightScore
";
            var cmd = CommandHelper.CreateText<GuessBet>(FetchType.Fetch, sql);
            cmd.Params.Add("@GuessId", guess.Id);
            cmd.Params.Add("@LeftScore", guess.BingoLeftScore);
            cmd.Params.Add("@RightScore", guess.BingoRightScore);
            var result = DbContext.GetInstance().Execute(cmd);
            return result.Entities.ToList<EntityBase, GuessBet>();
        }

        private List<GuessBet> GetGuessVictoryDefeatBetList(string betVSId, string GuessId)
        {
            var sql = @"
SELECT * 
FROM dbo.GuessBet 
WHERE BetVSId=@BetVSId
    AND GuessId=@GuessId
";
            var cmd = CommandHelper.CreateText<GuessBet>(FetchType.Fetch, sql);
            cmd.Params.Add("@BetVSId", betVSId);
            cmd.Params.Add("@GuessId", GuessId);
            var result = DbContext.GetInstance().Execute(cmd);
            return result.Entities.ToList<EntityBase, GuessBet>();
        }

        public Response UpdateGuess(string GuessId)
        {
            var sql = @"
UPDATE Guess 
SET 
    State=@State 
WHERE Id=@Id ";
            var cmd = CommandHelper.CreateText<ClubUser>(FetchType.Execute, sql);
            cmd.Params.Add("@State", GuessDic.AlreadySettlement);
            cmd.Params.Add("@Id", GuessId);

            var result = DbContext.GetInstance().Execute(cmd);
            SystemHelper.CheckResponseIfError(result);
            return result;
        }



    }

}
