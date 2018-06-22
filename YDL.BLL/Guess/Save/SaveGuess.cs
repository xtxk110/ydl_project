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
    /// 保存竞猜(包含修改和添加操作)
    /// </summary>
    public class SaveGuess_188 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<Guess>>(request);
            var guess = req.FirstEntity();
            Response rsp = ResultHelper.CreateResponse();
            //判断庄家的余额是否够
            var amount = guess.VictoryDefeatDeclarerDeposit + guess.ScoreDeclarerDeposit;//庄家押的悦豆
            int declarerAmount = Convert.ToInt32(amount);
            if (!GuessHelper.Instance.IsBalanceSufficient(guess.CreatorId, declarerAmount))
            {
                return ResultHelper.Fail(ErrorCode.YUEDOU_INSUFFICIENT, "没有足够的悦豆余额, 请充值");
            }

            //保存竞猜
            List<EntityBase> entites = new List<EntityBase>();
            entites.Add(guess);

            if (guess.RowState == RowState.Added)
            {
                guess.State = GuessDic.NotSettlement;
                guess.TrySetNewEntity();
            }

            //庄家押金相关处理
            if (guess.RowState == RowState.Added)
            {
                AddDeclarerDeposit(guess);
            }

            if (guess.RowState == RowState.Modified)
            {
                ModifiedDeclarerDeposit(guess);
            }

            //保存竞猜
            rsp = DbContext.GetInstance().Execute(CommandHelper.CreateSave(entites));
            //保存比分列表
            if (guess.GuessType == GuessDic.Score || guess.GuessType == GuessDic.VictoryDefeatAndScore)
            {
                rsp = SaveScoreList(guess);
            }

            return rsp;
        }




        ///// <summary>
        ///// 处理比分竞猜 庄家的押金投注
        ///// </summary>
        ///// <returns></returns>
        //private Response DealScoreDeclarerBet(Guess guess)
        //{
        //    Response rsp = ResultHelper.CreateResponse();

        //    if (guess.RowState == RowState.Added)//添加操作
        //    {
        //        //扣除庄家的投注
        //        rsp = SaveDeclarerBet(GuessDic.DeclarerScore, Convert.ToInt32(guess.ScoreDeclarerDeposit), guess);
        //        SystemHelper.CheckResponseIfError(rsp);
        //    }

        //    if (guess.RowState == RowState.Modified)////修改操作
        //    {
        //        var oldGuess = GuessHelper.Instance.GetGuess(guess.Id);

        //        //如果是从胜负竞猜切换到 比分竞猜,检查胜负竞猜那边有木有押金需要返回, 如果有就返还
        //        if ((oldGuess.GuessType == GuessDic.VictoryDefeat || oldGuess.GuessType == GuessDic.VictoryDefeatAndScore)
        //            && guess.GuessType == GuessDic.Score)
        //        {
        //            //返还之前的胜负投注
        //            UndoDeclarerBet(GuessDic.DeclarerVictoryDefeat, Convert.ToInt32(oldGuess.VictoryDefeatDeclarerDeposit), guess);
        //        }

        //        //先撤销之前的比分投注
        //        UndoDeclarerBet(GuessDic.DeclarerScore, Convert.ToInt32(oldGuess.ScoreDeclarerDeposit), guess);
        //        //再进行新的比分的投注
        //        SaveDeclarerBet(GuessDic.DeclarerScore, Convert.ToInt32(guess.ScoreDeclarerDeposit), guess);

        //    }


        //    return rsp;
        //}

        ///// <summary>
        ///// 处理胜负 庄家的押金投注
        ///// </summary>
        ///// <returns></returns>
        //private Response DeaVictoryDefeatDeclarerBet(Guess guess)
        //{
        //    Response rsp = ResultHelper.CreateResponse();

        //    if (guess.RowState == RowState.Added)//添加操作
        //    {
        //        //扣除庄家的投注
        //        rsp = SaveDeclarerBet(GuessDic.DeclarerVictoryDefeat, Convert.ToInt32(guess.VictoryDefeatDeclarerDeposit), guess);
        //        SystemHelper.CheckResponseIfError(rsp);
        //    }
        //    else if (guess.RowState == RowState.Modified)////修改操作
        //    {

        //        var oldGuess = GuessHelper.Instance.GetGuess(guess.Id);
        //        //如果是从比分竞猜切换到 胜负竞猜,检查比分竞猜那边有木有押金需要返回, 如果有就返还
        //        if ((oldGuess.GuessType == GuessDic.Score || oldGuess.GuessType == GuessDic.VictoryDefeatAndScore)
        //            && guess.GuessType == GuessDic.VictoryDefeat)
        //        {
        //            //返还之前的比分投注
        //            UndoDeclarerBet(GuessDic.DeclarerScore, Convert.ToInt32(oldGuess.ScoreDeclarerDeposit), guess);
        //        }


        //        //先撤销之前的胜负投注
        //        UndoDeclarerBet(GuessDic.DeclarerVictoryDefeat, Convert.ToInt32(oldGuess.VictoryDefeatDeclarerDeposit), guess);
        //        //再插入新的庄家胜负投注
        //        SaveDeclarerBet(GuessDic.DeclarerVictoryDefeat, Convert.ToInt32(guess.VictoryDefeatDeclarerDeposit), guess);

        //    }


        //    return rsp;
        //}


        public void AddDeclarerDeposit(Guess guess)
        {
            Response rsp = ResultHelper.CreateResponse();
            //比分竞猜的相关处理
            if (guess.GuessType == GuessDic.Score || guess.GuessType == GuessDic.VictoryDefeatAndScore)
            {
                //添加时扣除庄家的比分投注
                SaveDeclarerBet(GuessDic.DeclarerScore, Convert.ToInt32(guess.ScoreDeclarerDeposit), guess);
            }

            //胜负竞猜的相关处理
            if (guess.GuessType == GuessDic.VictoryDefeat || guess.GuessType == GuessDic.VictoryDefeatAndScore)
            {
                //添加时扣除庄家的胜负投注
                SaveDeclarerBet(GuessDic.DeclarerVictoryDefeat, Convert.ToInt32(guess.VictoryDefeatDeclarerDeposit), guess);
            }
        }

        /// <summary>
        /// 处理庄家押金修改
        /// </summary>
        /// <param name="guess"></param>
        /// <returns></returns>
        public void ModifiedDeclarerDeposit(Guess guess)
        {
            //先撤销之前的投注
            List<GuessBet> guessBetlist = GetDeclarerBetList(guess.Id);
            foreach (var item in guessBetlist)
            {
                UndoDeclarerBet(item.BetType, item.Amount, guess);
            }

            //庄家重新投注
            if (guess.GuessType == GuessDic.Score || guess.GuessType == GuessDic.VictoryDefeatAndScore)
            {
                //重新投注比分
                SaveDeclarerBet(GuessDic.DeclarerScore, Convert.ToInt32(guess.ScoreDeclarerDeposit), guess);
            }

            if (guess.GuessType == GuessDic.VictoryDefeat || guess.GuessType == GuessDic.VictoryDefeatAndScore)
            {
                //重新投注胜负
                SaveDeclarerBet(GuessDic.DeclarerVictoryDefeat, Convert.ToInt32(guess.VictoryDefeatDeclarerDeposit), guess);
            }

        }

        /// <summary>
        /// 获取庄家的投注记录
        /// </summary>
        /// <returns></returns>
        public List<GuessBet> GetDeclarerBetList(string GuessId)
        {

            var sql = @"
SELECT *
FROM dbo.GuessBet 
WHERE GuessId=@GuessId 
        AND (BetType='DeclarerScore' OR BetType='DeclarerVictoryDefeat') 

";
            var cmd = CommandHelper.CreateText<GuessBet>(FetchType.Fetch, sql);
            cmd.Params.Add("@GuessId", GuessId);
            var result = DbContext.GetInstance().Execute(cmd);
            return result.Entities.ToList<EntityBase, GuessBet>() ?? new List<GuessBet>();
        }


        /// <summary>
        /// 保存庄家的投注
        /// </summary>
        /// <param name="amount">庄家的投注总悦豆</param>
        /// <param name="guess"></param>
        /// <returns></returns>
        private void SaveDeclarerBet(string betType, int amount, Guess guess)
        {
            Response rsp = ResultHelper.CreateResponse();
            //扣除庄家的悦豆
            rsp = GuessHelper.Instance.AddOrSubYueDou(-amount, guess.CreatorId);
            SystemHelper.CheckResponseIfError(rsp);

            // 插入庄家的投注记录
            GuessBet obj = new GuessBet();
            List<EntityBase> entites = new List<EntityBase>();
            entites.Add(obj);
            obj.RowState = RowState.Added;
            obj.Amount = amount;
            obj.GuessId = guess.Id;
            obj.UserId = guess.CreatorId;
            obj.BetType = betType;
            obj.TrySetNewEntity();

            rsp = DbContext.GetInstance().Execute(CommandHelper.CreateSave(entites));
            SystemHelper.CheckResponseIfError(rsp);

            //插入悦豆消费账单
            var yueDouFlow = new YueDouFlow();
            yueDouFlow.Amount = -amount;
            yueDouFlow.UserId = guess.CreatorId;
            yueDouFlow.FlowType = GuessDic.GuessCost;
            yueDouFlow.GuessId = guess.Id;
            rsp = GuessHelper.Instance.AddYueDouFlow(yueDouFlow);
            SystemHelper.CheckResponseIfError(rsp);

        }


        /// <summary>
        /// 撤销庄家的投注
        /// </summary>
        /// <param name="amount">庄家之前的投注总悦豆</param>
        /// <param name="guess"></param>
        /// <returns></returns>
        private Response UndoDeclarerBet(string betType, int amount, Guess guess)
        {
            Response rsp = ResultHelper.CreateResponse();
            if (amount > 0)
            {
                //返回庄家的悦豆
                rsp = GuessHelper.Instance.AddOrSubYueDou(amount, guess.CreatorId);
                SystemHelper.CheckResponseIfError(rsp);
                //插入悦豆返回账单
                var yueDouFlow = new YueDouFlow();
                yueDouFlow.Amount = amount;
                yueDouFlow.UserId = guess.CreatorId;
                yueDouFlow.FlowType = GuessDic.DepositReturn;
                yueDouFlow.GuessId = guess.Id;
                rsp = GuessHelper.Instance.AddYueDouFlow(yueDouFlow);
                SystemHelper.CheckResponseIfError(rsp);

            }

            //删除庄家的投注记录
            var sql = @"
 DELETE FROM dbo.GuessBet 
 WHERE
		GuessId=@GuessId
		AND UserId=@UserId
		AND BetType=@BetType

";
            var cmd = CommandHelper.CreateText<ClubUser>(FetchType.Execute, sql);
            cmd.Params.Add("@GuessId", guess.Id);
            cmd.Params.Add("@UserId", guess.CreatorId);
            cmd.Params.Add("@BetType", betType);
            rsp = DbContext.GetInstance().Execute(cmd);
            SystemHelper.CheckResponseIfError(rsp);

            return rsp;
        }


        /// <summary>
        /// 保存比分赔率列表(包含添加和修改操作)
        /// </summary>
        /// <returns></returns>
        private Response SaveScoreList(Guess guess)
        {
            //先删除
            var sql = @"DELETE FROM dbo.GuessScore WHERE GuessId=@GuessId ";
            var cmd = CommandHelper.CreateText<Guess>(FetchType.Execute, sql);
            cmd.Params.Add("@GuessId", guess.Id);
            DbContext.GetInstance().Execute(cmd);

            //后添加
            List<EntityBase> entites = new List<EntityBase>();
            foreach (var obj in guess.ScoreList)
            {
                entites.Add(obj);
                obj.RowState = RowState.Added;
                obj.GuessId = guess.Id;
                obj.TrySetNewEntity();
            }
            var result = DbContext.GetInstance().Execute(CommandHelper.CreateSave(entites));
            SystemHelper.CheckResponseIfError(result);
            return result;
        }

    }

}
