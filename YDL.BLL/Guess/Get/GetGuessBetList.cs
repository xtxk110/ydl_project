
using System.Collections.Generic;
using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Utility;
using YDL.Core;
using System;

namespace YDL.BLL
{
    /// <summary>
    /// 获取竞猜记录(投注)列表
    /// </summary>
    public class GetGuessBetList_188 : IServiceBase
    {

        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetGuessRelatedFilter>>(request);
            var cmd = CommandHelper.CreateProcedure<GuessBet>(text: "GetGuessBetList");
            cmd.Params.Add(CommandHelper.CreateParam("@UserId", req.Filter.CurrentUserId));
            cmd.Params.Add(CommandHelper.CreateParam("@GameId", req.Filter.GameId));

            cmd.CreateParamPager(req.Filter);

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();
            foreach (var item in result.Entities)
            {
                var guessBet = item as GuessBet;
                //获取竞猜
                var guess = GuessHelper.Instance.GetGuess(guessBet.GuessId);
                //获取对阵详情
                guessBet.GuessVSDetail = GuessHelper.Instance.GetVSDetail(guess);
                //设置对阵结果
                SetVSResult(guessBet, guess);
                //设置赔率
                SetOdds(guessBet, guess);
                //设置猜中的结果
                SetBingoResult(guessBet, guess);
            }
            return result;
        }

        public void SetBingoResult(GuessBet guessBet, Guess guess)
        {
            if (guess.State != GuessDic.AlreadySettlement)//未结算
            {
                guessBet.BingoResult = "等待结算";
                guessBet.BingoResultState = GuessDic.WaitSettlement;
            }

            if (guess.State == GuessDic.AlreadySettlement)//已结算
            {
                if (guessBet.BetType == GuessDic.VictoryDefeat)//胜负竞猜
                {
                    SetVictoryDefeatBingoResult(guessBet, guess);
                }
                else if (guessBet.BetType == GuessDic.Score)//比分竞猜
                {
                    SetScoreBingoResult(guessBet, guess);
                }
                else if (guessBet.BetType == GuessDic.DeclarerVictoryDefeat)//胜负坐庄
                {
                    int victoryDefeatBackYueDou = GetBackYueDouToDeclarer(guess.Id, GuessDic.DeclarerVictoryDefeat);
                    int victoryDefeatDeposit = Convert.ToInt32(guess.VictoryDefeatDeclarerDeposit);
                    SetDeclarerBingoResult(guessBet, victoryDefeatDeposit, victoryDefeatBackYueDou);
                }
                else if (guessBet.BetType == GuessDic.DeclarerScore)//比分坐庄
                {
                    int scoreBackYueDou = GetBackYueDouToDeclarer(guess.Id, GuessDic.DeclarerScore);
                    int scoreDeposit = Convert.ToInt32(guess.ScoreDeclarerDeposit);
                    SetDeclarerBingoResult(guessBet, scoreDeposit, scoreBackYueDou);
                }
            }
        }

        public void SetDeclarerBingoResult(GuessBet guessBet, int originYueDou, int backYueDou)
        {
            var differenceValue = originYueDou - backYueDou;
            if (differenceValue == 0)//不赚不亏
            {
                guessBet.BingoResult = "0";
            }
            else if (differenceValue > 0)//亏了
            {
                guessBet.BingoResult = "-" + differenceValue + "悦豆";
            }
            else if (differenceValue < 0)//赚了
            {
                guessBet.BingoResult = "+" + (-differenceValue) + "悦豆";
            }
        }

        /// <summary>
        /// 获取返还给庄家的悦豆
        /// </summary>
        public int GetBackYueDouToDeclarer(string guessId, string GuessBetType)
        {

            var sql = @"
SELECT * 
FROM dbo.YueDouFlow
WHERE 
      GuessId=@GuessId
	AND GuessBetType=@GuessBetType

";
            var cmd = CommandHelper.CreateText<YueDouFlow>(FetchType.Fetch, sql);
            cmd.Params.Add("@GuessId", guessId);
            cmd.Params.Add("@GuessBetType", GuessBetType);
            var result = DbContext.GetInstance().Execute(cmd);
            var obj = result.FirstEntity<YueDouFlow>();
            if (obj != null)
            {
                return obj.Amount;
            }
            else
            {
                return 0;
            }

        }

        /// <summary>
        /// 设置比分竞猜猜中的结果
        /// </summary>
        /// <param name="guessBet"></param>
        /// <param name="guess"></param>
        public void SetScoreBingoResult(GuessBet guessBet, Guess guess)
        {
            GuessHelper.Instance.SetBingoScoreAndOdds(guess, guessBet.GuessVSDetail);
            if (guessBet.LeftScore == guess.BingoLeftScore
                && guessBet.RightScore == guess.BingoRightScore)
            {
                decimal earnYueDou = guessBet.Amount * (guessBet.BetOdds - 1);//算出赚的悦豆
                guessBet.BingoResult = "猜中 +" + earnYueDou + "悦豆";
                guessBet.BingoResultState = GuessDic.Bingo;
            }
            else
            {
                guessBet.BingoResult = "未猜中";
            }

        }

        /// <summary>
        /// 设置胜负竞猜猜中的结果
        /// </summary>
        /// <param name="guessBet"></param>
        /// <param name="guess"></param>
        public void SetVictoryDefeatBingoResult(GuessBet guessBet, Guess guess)
        {
            GuessHelper.Instance.SetVictoryIdAndOdds(guess, guessBet.GuessVSDetail);
            if (guessBet.BetVSId == guess.VictoryId)//猜中了
            {
                decimal earnYueDou = guessBet.Amount * (guessBet.BetOdds - 1);//算出赚的悦豆
                guessBet.BingoResult = "猜中 +" + earnYueDou + "悦豆";
                guessBet.BingoResultState = GuessDic.Bingo;
            }
            else
            {
                guessBet.BingoResult = "未猜中";
            }
        }

        /// <summary>
        /// 设置用户这条投注记录 对应的赔率
        /// </summary>
        public void SetOdds(GuessBet obj, Guess guess)
        {
            if (obj.BetType == GuessDic.VictoryDefeat)//胜负竞猜
            {
                if (obj.BetVSId == guess.VSLeftId)//如果相等, 说明我投的是左边
                {
                    obj.BetOdds = guess.VSLeftOdds;
                }
                else
                {
                    obj.BetOdds = guess.VsRightOdds;
                }
            }
            else if (obj.BetType == GuessDic.Score)//比分竞猜
            {
                //获取投注的这个比分对应的赔率
                var guessScore =GuessHelper.Instance.GetGuessScore(guess.Id, obj.LeftScore
                              , obj.RightScore);
                if (guessScore != null)
                {
                    obj.BetOdds = guessScore.Odds;
                }
            }

        }

        /// <summary>
        /// 设置对阵结果
        /// </summary>
        /// <param name="obj"></param>
        /// <param name="guess"></param>
        public void SetVSResult(GuessBet obj, Guess guess)
        {
            if (obj.GuessVSDetail.State == GameLoopState.FINISH.Id)
            {
                if (obj.BetType == GuessDic.VictoryDefeat)//胜负竞猜
                {
                    SetVictoryDefeatVSResult(obj, guess);
                }
                else if (obj.BetType == GuessDic.Score)//比分竞猜
                {
                    obj.VSResult = string.Format("全场比分 {0}:{1}"
                                , obj.GuessVSDetail.LeftScore, obj.GuessVSDetail.RightScore);
                }
                else if (obj.BetType == GuessDic.DeclarerVictoryDefeat)//胜负竞猜坐庄
                {
                    obj.VSResult = "胜负坐庄";
                }
                else if (obj.BetType == GuessDic.DeclarerScore)//比分竞猜坐庄
                {
                    obj.VSResult = "比分坐庄";
                }
            }
            else //进行中
            {
                if (obj.BetType == GuessDic.DeclarerVictoryDefeat)//胜负竞猜坐庄
                {
                    obj.VSResult = "进行中(胜负坐庄)";
                }
                else if (obj.BetType == GuessDic.DeclarerScore)//比分竞猜坐庄
                {
                    obj.VSResult = "进行中(比分坐庄)";
                }
                else
                {
                    obj.VSResult = "进行中";
                }
            }
        }

        public void SetVictoryDefeatVSResult(GuessBet obj, Guess guess)
        {
            if (obj.LeftScore > obj.RightScore)
            {
                string victoryName = "";
                if (obj.GuessVSDetail.LeftName.Length > 5)//保留5个汉字
                {
                    victoryName = obj.GuessVSDetail.LeftName.Substring(0, 5) + "..." + " 胜";
                }
                else
                {
                    victoryName = obj.GuessVSDetail.LeftName + " 胜";
                }
                obj.VSResult = victoryName;
            }
            else
            {
                string victoryName = "";
                if (obj.GuessVSDetail.RightName.Length > 5)//保留5个汉字
                {
                    victoryName = obj.GuessVSDetail.RightName.Substring(0, 5) + "..." + " 胜";
                }
                else
                {
                    victoryName = obj.GuessVSDetail.RightName + " 胜";
                }
                obj.VSResult = victoryName;

            }
        }

      

    }

}
