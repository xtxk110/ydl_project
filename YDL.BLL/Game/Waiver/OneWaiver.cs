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
    class OneWaiver : IWaiver
    {
        public void SetScore(EntityBase loopObj)
        {
            var loop = (GameLoop)loopObj;
            loop.Fen1 = 0;
            loop.Fen2 = 0;
            loop.Game1 = 0;
            loop.Game2 = 0;
            loop.Score1 = 0;
            loop.Score2 = 0;
            loop.Team1 = 0;
            loop.Team2 = 0;
            if (loop.DetailList.IsNotNullOrEmpty())
            {
                TotalDetail(loop);
            }
            if (loop.Game1 > loop.Game2)
            {
                loop.Score1 = Globals.TT_SCORE_WIN;
                loop.Score2 = Globals.TT_SCORE_FAIL;
            }
            else if (loop.Game1 < loop.Game2)
            {
                loop.Score1 = Globals.TT_SCORE_FAIL;
                loop.Score2 = Globals.TT_SCORE_WIN;
            }
            loop.State = GameLoopState.FINISH.Id;
            loop.SetRowModified();
        }

        private static void TotalDetail(GameLoop loop)
        {
            foreach (var obj in loop.DetailList)
            {
                if (obj != null && (obj.Fen1 > 0 || obj.Fen2 > 0))
                {
                    loop.Fen1 += obj.Fen1;
                    loop.Fen2 += obj.Fen2;
                    if (obj.Fen1 > obj.Fen2)
                    {
                        loop.Game1++;
                    }
                    else
                    {
                        loop.Game2++;
                    }
                }
            }
        }

        public void SetWaiver(EntityBase loopObj)
        {
            var loop = (GameLoop)loopObj;
            var order = GameHelper.GetGameOrder(loop.OrderId);
            if (loop.WaiverOption == WaiverOption.A)
            {
                loop.Score1 = Globals.TT_SCORE_WAIVER;
                loop.Score2 = Globals.TT_SCORE_WIN;
                loop.Game1 = 0;
                loop.Game2 = order.WinGame;
                loop.Fen1 = 0;
                loop.Fen2 = order.WinGame * Globals.TT_ONE_GAME_FEN;
            }
            else if (loop.WaiverOption == WaiverOption.B)
            {
                loop.Score1 = Globals.TT_SCORE_WIN;
                loop.Score2 = Globals.TT_SCORE_WAIVER;
                loop.Game1 = order.WinGame;
                loop.Game2 = 0;
                loop.Fen1 = order.WinGame * Globals.TT_ONE_GAME_FEN;
                loop.Fen2 = 0;
            }
            else
            {
                loop.Score1 = Globals.TT_SCORE_WAIVER;
                loop.Score2 = Globals.TT_SCORE_WAIVER;
                loop.Game1 = 0;
                loop.Game2 = 0;
                loop.Fen1 = 0;
                loop.Fen2 = 0;
            }
        }
    }
}
