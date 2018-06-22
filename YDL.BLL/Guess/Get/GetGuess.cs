
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
    /// 获取竞猜详情
    /// </summary>
    public class GetGuess_188 : IService
    {

        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetGuessRelatedFilter>>(request);
            var sql = @"
SELECT 
		a.*,
		CreatorName=dbo.fn_GetUserName(a.CreatorId) 
FROM dbo.Guess a
LEFT JOIN dbo.UserAccount b ON a.CreatorId=b.Id
WHERE a.Id=@Id
";
            var cmd = CommandHelper.CreateText<Guess>(FetchType.Fetch, sql);
            cmd.Params.Add("@Id", req.Filter.GuessId);
            var result = DbContext.GetInstance().Execute(cmd);
            var guess = result.FirstEntity<Guess>();
            //获取对阵信息
            guess.GuessVSDetail = GuessHelper.Instance.GetVSDetail(guess);

            //获取竞猜比分列表
            GetGuessScoreList(guess);
            //处理竞猜状态
            GuessHelper.Instance.DealState(guess);

            guess.PersonTotal = GuessHelper.Instance.GetGuessTotalPerson(guess.Id);
            guess.YueDouTotal = GuessHelper.Instance.GetGuessTotalYueDou(guess.Id);
            //如果已结算,显示已结算金额
            if (guess.State == GuessDic.AlreadySettlement)
            {
                SetSettlement(guess);
            }

            return result;
        }

        /// <summary>
        /// 设置已结算金额
        /// </summary>
        /// <param name="guess"></param>
        public void SetSettlement(Guess guess)
        {
            //胜负竞猜
            if (guess.GuessType == GuessDic.VictoryDefeat)
            {
                SetVictoryDefeatSettlement(guess);
            }
            //比分竞猜
            if (guess.GuessType == GuessDic.Score)
            {
                SetScoreSettlement(guess);
            }

            //胜负比分竞猜
            if (guess.GuessType == GuessDic.VictoryDefeatAndScore)
            {
                SetVictoryDefeatSettlement(guess);
                SetScoreSettlement(guess);
            }

        }

        /// <summary>
        /// 设置比分竞猜已结算金额
        /// </summary>
        private void SetScoreSettlement(Guess guess)
        {
            //设置猜中的比分和赔率
            GuessHelper.Instance.SetBingoScoreAndOdds(guess, guess.GuessVSDetail);
            //比分投注的总悦豆
            var scoreTotalYuedou = GuessHelper.Instance
                .GetGuessTotalYueDouByType(guess.Id, GuessDic.Score);
            //猜中比分的总悦豆
            var bingoScoreTotalYueDou = GuessHelper
                .Instance.GetBingoScoreTotalYueDou(guess);
            //算出猜中比分悦豆所占百分比
            decimal bingoScorePercent = 0;
            if (scoreTotalYuedou != 0)
            {
                bingoScorePercent = (Convert.ToDecimal(bingoScoreTotalYueDou)
                           / Convert.ToDecimal(scoreTotalYuedou)
                     ) * 100;
                bingoScorePercent = Math.Round(bingoScorePercent, 2);
            }
           
            var guessScore = guess.ScoreList.Where(e => e.LeftScore == guess.BingoLeftScore
                && e.RightScore == guess.BingoRightScore).FirstOrDefault();
            if (guessScore != null)
            {
                guessScore.BingoTotalYueDou = bingoScoreTotalYueDou;
                guessScore.BingoTotalYueDouPercent = bingoScorePercent;
                //设置为最终比分
                guessScore.IsFinalScore = true;
            }

           

        }

        /// <summary>
        /// 设置胜负竞猜已结算金额
        /// </summary>
        private void SetVictoryDefeatSettlement(Guess guess)
        {
            //设置胜方的id 和赔率
            GuessHelper.Instance.SetVictoryIdAndOdds(guess, guess.GuessVSDetail);
            //胜负投注的总悦豆
            var victoryDefeatTotalYuedou = GuessHelper.Instance
                .GetGuessTotalYueDouByType(guess.Id, GuessDic.VictoryDefeat);

            //胜方总悦豆
            var victoryTotalYueDou = GuessHelper.Instance
                .GetVictoryOrDefeatTotalYueDou(guess.Id, guess.VictoryId);

            //算出胜方悦豆所占百分比
            decimal victoryPercent = 0;
            if (victoryDefeatTotalYuedou != 0)
            {
                victoryPercent = (
                    Convert.ToDecimal(victoryTotalYueDou) / Convert.ToDecimal(victoryDefeatTotalYuedou)
                    ) * 100;
                victoryPercent = Math.Round(victoryPercent, 2);
            }

            //设置胜方的结算值
            guess.GuessVSDetail.VictoryId = guess.VictoryId;
            guess.GuessVSDetail.VictoryOdds = guess.VictoryOdds;
            guess.GuessVSDetail.VictoryTotalYueDou = victoryTotalYueDou;
            guess.GuessVSDetail.VictoryTotalYueDouPercent = victoryPercent;

        }

        private void GetGuessScoreList(Guess obj)
        {
            var sql = @"

 SELECT * 
 FROM dbo.GuessScore 
 WHERE GuessId=@GuessId
 ORDER BY LeftScore DESC ,RightScore ASC

";
            var cmd = CommandHelper.CreateText<GuessScore>(FetchType.Fetch, sql);
            cmd.Params.Add("@GuessId", obj.Id);
            var result = DbContext.GetInstance().Execute(cmd);
            if (result.Entities.Count > 0)
            {
                obj.ScoreList.AddRange(result.Entities.ToList<EntityBase, GuessScore>());
            }
        }

    }

}
