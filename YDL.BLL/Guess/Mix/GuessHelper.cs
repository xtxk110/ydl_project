using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Core;
using YDL.Map;
using YDL.Model;
using YDL.Utility;

namespace YDL.BLL
{
    public class GuessHelper
    {
        public static GuessHelper Instance = new GuessHelper();
        /// <summary>
        /// 查询对阵详情
        /// </summary>
        /// <param name="guess"></param>
        public GuessVS GetVSDetail(Guess guess)
        {
            var cmd = CommandHelper.CreateProcedure<GameLoop>(text: "sp_GetGameOrderVSDetail");
            cmd.Params.Add(CommandHelper.CreateParam("@gameId", ""));
            cmd.Params.Add(CommandHelper.CreateParam("@knockOutAB", ""));
            cmd.Params.Add(CommandHelper.CreateParam("@orderId", guess.VsOrderId));
            cmd.Params.Add(CommandHelper.CreateParam("@groupId", ""));
            cmd.Params.Add(CommandHelper.CreateParam("@isExtra", ""));
            guess.VsOrderNo = 0;//排查后,此值用不到, 暂时屏蔽
            cmd.Params.Add(CommandHelper.CreateParam("@groupOrderNo", guess.VsOrderNo));
            cmd.Params.Add(CommandHelper.CreateParam("@GameLoopId", guess.VsGameLoopId));
            var result = DbContext.GetInstance().Execute(cmd);
            var obj = result.FirstEntity<GameLoop>();

            GuessVS guessVS = new GuessVS();
            guessVS.LeftId = obj.Team1Id.GetId();
            guessVS.LeftName = obj.Team1Id.GetName();
            guessVS.LeftHeadUrl = obj.Team1HeadUrl;
            if (obj.IsTeam)
            {
                guessVS.LeftScore = obj.Team1;
            }
            else
            {
                guessVS.LeftScore = obj.Game1;

            }

            guessVS.RightId = obj.Team2Id.GetId();
            guessVS.RightName = obj.Team2Id.GetName();
            guessVS.RightHeadUrl = obj.Team2HeadUrl;
            if (obj.IsTeam)
            {
                guessVS.RightScore = obj.Team2;
            }
            else
            {
                guessVS.RightScore = obj.Game2;
            }

            guessVS.TableNumber = obj.TableNo;
            guessVS.MasterJudgeName = obj.MasterJudgeId.GetName();
            guessVS.SecondJudgeName = obj.JudgeId.GetName();
            guessVS.BeginTime = obj.BeginTime;
            guessVS.State = obj.State.GetId();
            guessVS.GameId = obj.GameId;
            //设置对阵左右两边的赔率
            guessVS.LeftOdds = guess.VSLeftOdds;
            guessVS.RightOdds = guess.VsRightOdds;
            //设置几打几胜
            guessVS.WinNumber = obj.IsTeam ? obj.WinTeam : obj.WinGame;
            return guessVS;

        }

        //处理竞猜状态
        public void DealState(Guess guess)
        {
            //只要没结算就 计算出竞猜的状态, 如果结算了就不处理竞猜状态
            if (guess.State != GuessDic.AlreadySettlement)
            {
                if (DateTime.Now < guess.BeginTime)
                {
                    guess.State = GuessDic.NotPublish;
                }
                else if (DateTime.Now < guess.EndTime && DateTime.Now > guess.BeginTime)
                {
                    guess.State = GuessDic.Processing;
                }
                else if (DateTime.Now > guess.EndTime)
                {
                    guess.State = GuessDic.Finished;
                }
            }
        }

        /// <summary>
        /// 添加悦豆消费充值账单记录
        /// </summary>
        /// <returns></returns>
        public Response AddYueDouFlow(YueDouFlow obj)
        {

            List<EntityBase> entites = new List<EntityBase>();
            entites.Add(obj);
            obj.RowState = RowState.Added;
            obj.TrySetNewEntity();
            var result = DbContext.GetInstance().Execute(CommandHelper.CreateSave(entites));

            return result;

        }

        /// <summary>
        /// 增减悦豆(如果用户悦豆余额记录不存在,会创建一条余额记录)
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
        public Response AddOrSubYueDou(int Amount, string UserId)
        {
            Response rsp = ResultHelper.CreateResponse();
            //先判断此用户是否存在余额记录
            var balance = GetYueDouBalance(UserId);
            if (balance == null)
            {
                //不存在就插入初始记录
                YueDou obj = new YueDou();
                List<EntityBase> entites = new List<EntityBase>();
                entites.Add(obj);
                obj.UserId = UserId;
                obj.Balance = 0;
                obj.RowState = RowState.Added;
                obj.TrySetNewEntity();
                rsp = DbContext.GetInstance().Execute(CommandHelper.CreateSave(entites));
                if (!rsp.IsSuccess)
                {
                    return rsp;
                }
            }

            //增减悦豆
            var sql = @" UPDATE dbo.YueDou SET Balance=Balance+@Amount WHERE UserId=@UserId ";
            var cmd = CommandHelper.CreateText<ClubUser>(FetchType.Execute, sql);
            cmd.Params.Add("@Amount", Amount);//正数加, 负数为减
            cmd.Params.Add("@UserId", UserId);
            rsp = DbContext.GetInstance().Execute(cmd);
            return rsp;

        }

        /// <summary>
        /// 获取竞猜 
        /// </summary>
        /// <param name="GuessId"></param>
        /// <returns></returns>
        public Guess GetGuess(string GuessId)
        {
            var sql = @"
SELECT 
		a.*
FROM dbo.Guess a
WHERE a.Id=@GuessId
";
            var cmd = CommandHelper.CreateText<Guess>(FetchType.Fetch, sql);
            cmd.Params.Add("@GuessId", GuessId);
            var result = DbContext.GetInstance().Execute(cmd);
            var obj = result.FirstEntity<Guess>();
            return obj ?? new Guess();
        }

        /// <summary>
        /// 获取 总的悦豆( 包括胜负竞猜和比分竞猜的所有悦豆)
        /// </summary>
        /// <param name="GuessId"></param>
        /// <param name="BetType">投注的类型</param>
        /// <returns></returns>
        public int GetGuessTotalYueDou(string GuessId)
        {

            var sql = @"
 SELECT 
	SUM(Amount) AS Amount
 FROM dbo.GuessBet 
 WHERE  GuessId=@GuessId
";
            var cmd = CommandHelper.CreateText<GuessBet>(FetchType.Fetch, sql);
            cmd.Params.Add("@GuessId", GuessId);

            var result = DbContext.GetInstance().Execute(cmd);
            var obj = result.FirstEntity<GuessBet>();
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
        /// 根据 胜负竞猜或比分竞猜 类型来获取对应的 总的悦豆
        /// </summary>
        /// <param name="GuessId"></param>
        /// <param name="BetType">投注的类型</param>
        /// <returns></returns>
        public int GetGuessTotalYueDouByType(string GuessId, string BetType)
        {

            var sql = @"
 SELECT 
	SUM(Amount) AS Amount
 FROM dbo.GuessBet 
 WHERE  GuessId=@GuessId
        AND BetType=@BetType
";
            var cmd = CommandHelper.CreateText<GuessBet>(FetchType.Fetch, sql);
            cmd.Params.Add("@GuessId", GuessId);
            cmd.Params.Add("@BetType", BetType);

            var result = DbContext.GetInstance().Execute(cmd);
            var obj = result.FirstEntity<GuessBet>();
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
        /// 获取此竞猜的总人数
        /// </summary>
        /// <param name="GuessId"></param>
        /// <returns></returns>
        public int GetGuessTotalPerson(string GuessId)
        {

            var sql = @"
SELECT 
	COUNT(DISTINCT UserId) AS Amount
FROM dbo.GuessBet
WHERE GuessId=@GuessId
";
            var cmd = CommandHelper.CreateText<GuessBet>(FetchType.Fetch, sql);
            cmd.Params.Add("@GuessId", GuessId);
            var result = DbContext.GetInstance().Execute(cmd);
            var obj = result.FirstEntity<GuessBet>();
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
        /// 设置胜方的Id 和赔率到Guess 实体上
        /// </summary>
        /// <param name="guess"></param>
        /// <param name="obj"></param>
        public void SetVictoryIdAndOdds(Guess guess, GuessVS obj)
        {
            //获取胜方Id
            if (obj.LeftScore > obj.RightScore)
            {
                guess.VictoryId = obj.LeftId;
            }
            else
            {
                guess.VictoryId = obj.RightId;
            }
            //获取胜方赔率
            if (guess.VictoryId == obj.LeftId)
            {
                guess.VictoryOdds = guess.VSLeftOdds;
            }
            else
            {
                guess.VictoryOdds = guess.VsRightOdds;
            }
        }

        /// <summary>
        /// 设置猜中的比分和赔率到Guess实体上
        /// </summary>
        /// <param name="guess"></param>
        /// <param name="obj"></param>
        public void SetBingoScoreAndOdds(Guess guess, GuessVS obj)
        {

            var sql = @"
 SELECT * 
 FROM dbo.GuessScore
 WHERE GuessId=@GuessId
	AND  LeftScore=@LeftScore
	AND RightScore=@RightScore
";
            var cmd = CommandHelper.CreateText<GuessScore>(FetchType.Fetch, sql);
            cmd.Params.Add("@GuessId", guess.Id);
            cmd.Params.Add("@LeftScore", obj.LeftScore);
            cmd.Params.Add("@RightScore", obj.RightScore);
            var result = DbContext.GetInstance().Execute(cmd);
            var guessScore = result.FirstEntity<GuessScore>();
            guess.BingoLeftScore = guessScore.LeftScore;
            guess.BingoRightScore = guessScore.RightScore;
            guess.BingoScoreOdds = guessScore.Odds;

        }

        /// <summary>
        /// 获取猜错比分的总悦豆,不包括庄家的(比分竞猜)
        /// </summary>
        /// <param name="GuessId"></param>
        /// <param name="BetVSId"></param>
        /// <returns></returns>
        public int GetNotBingoScoreTotalYueDou(Guess guess)
        {
            var sql = @"
 SELECT 
		SUM(Amount) AS Amount
 FROM dbo.GuessBet 
 WHERE  GuessId=@GuessId
	AND LeftScore!=@LeftScore
	AND RightScore!=@RightScore
    AND BetType !='DeclarerScore' 
    AND BetType !='DeclarerVictoryDefeat' 
";
            var cmd = CommandHelper.CreateText<GuessBet>(FetchType.Fetch, sql);
            cmd.Params.Add("@GuessId", guess.Id);
            cmd.Params.Add("@LeftScore", guess.BingoLeftScore);
            cmd.Params.Add("@RightScore", guess.BingoRightScore);

            var result = DbContext.GetInstance().Execute(cmd);
            var obj = result.FirstEntity<GuessBet>();
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
        /// 获取猜对比分的总悦豆,不包括庄家的(比分竞猜)
        /// </summary>
        /// <param name="GuessId"></param>
        /// <param name="BetVSId"></param>
        /// <returns></returns>
        public int GetBingoScoreTotalYueDou(Guess guess)
        {
            var sql = @"
 SELECT 
		SUM(Amount) AS Amount
 FROM dbo.GuessBet 
 WHERE  GuessId=@GuessId
	AND LeftScore=@LeftScore
	AND RightScore=@RightScore
";
            var cmd = CommandHelper.CreateText<GuessBet>(FetchType.Fetch, sql);
            cmd.Params.Add("@GuessId", guess.Id);
            cmd.Params.Add("@LeftScore", guess.BingoLeftScore);
            cmd.Params.Add("@RightScore", guess.BingoRightScore);

            var result = DbContext.GetInstance().Execute(cmd);
            var obj = result.FirstEntity<GuessBet>();
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
        /// 获取胜方或负方总的悦豆,不包括庄家的(胜负竞猜)
        /// </summary>
        /// <param name="GuessId"></param>
        /// <param name="BetVSId"></param>
        /// <returns></returns>
        public int GetVictoryOrDefeatTotalYueDou(string GuessId, string BetVSId)
        {
            var sql = @"
 SELECT 
		SUM(Amount) AS Amount
 FROM dbo.GuessBet 
 WHERE  GuessId=@GuessId
	AND BetVSId=@BetVSId
";
            var cmd = CommandHelper.CreateText<GuessBet>(FetchType.Fetch, sql);
            cmd.Params.Add("@GuessId", GuessId);
            cmd.Params.Add("@BetVSId", BetVSId);

            var result = DbContext.GetInstance().Execute(cmd);
            var obj = result.FirstEntity<GuessBet>();
            if (obj != null)
            {
                return obj.Amount;
            }
            else
            {
                return 0;
            }
        }

        public bool IsBalanceSufficient(string userId, int amount)
        {
            var sql = @"
SELECT * FROM dbo.YueDou WHERE UserId=@UserId
";
            var cmd = CommandHelper.CreateText<YueDou>(FetchType.Fetch, sql);
            cmd.Params.Add("@UserId", userId);
            var result = DbContext.GetInstance().Execute(cmd);
            var obj = result.FirstEntity<YueDou>();
            if (obj == null)
            {
                return false;
            }
            if (obj.Balance >= amount)
            {
                return true;
            }
            else
            {
                return false;
            }

        }

        /// <summary>
        /// 获取悦豆余额
        /// </summary>
        /// <param name="UserId"></param>
        /// <returns></returns>
        public YueDou GetYueDouBalance(string UserId)
        {
            var sql = @"
SELECT * FROM dbo.YueDou WHERE UserId=@UserId
";
            var cmd = CommandHelper.CreateText<YueDou>(FetchType.Fetch, sql);
            cmd.Params.Add("@UserId", UserId);
            var result = DbContext.GetInstance().Execute(cmd);
            return result.FirstEntity<YueDou>() ?? new YueDou();
        }

        public GuessScore GetGuessScore(string guessId, int leftScore, int rightScore)
        {
            var sql = @"

SELECT * 
FROM dbo.GuessScore
WHERE  
      GuessId=@GuessId
	  AND LeftScore=@LeftScore
	  AND RightScore=@RightScore
";
            var cmd = CommandHelper.CreateText<GuessScore>(FetchType.Fetch, sql);
            cmd.Params.Add("@GuessId", guessId);
            cmd.Params.Add("@LeftScore", leftScore);
            cmd.Params.Add("@RightScore", rightScore);
            var result = DbContext.GetInstance().Execute(cmd);
            return result.FirstEntity<GuessScore>();
        }

    }
}
