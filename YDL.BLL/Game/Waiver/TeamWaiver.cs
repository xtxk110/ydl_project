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
    class TeamWaiver : IWaiver
    {
        public void SetScore(EntityBase loopObj)
        {
            var loop = (GameLoop)loopObj;
            var maps = GameHelper.GetLoopMapList(loop.Id);
            var order = GameHelper.GetGameOrder(loop.OrderId);

            loop.Fen1 = 0;
            loop.Fen2 = 0;
            loop.Game1 = 0;
            loop.Game2 = 0;
            loop.Score1 = 0;
            loop.Score2 = 0;
            loop.Team1 = 0;
            loop.Team2 = 0;

            foreach (var item in maps)
            {
                var obj = item as GameLoopMap;
                if (obj != null && (obj.Fen1 > 0 || obj.Fen2 > 0))
                {
                    loop.Fen1 += obj.Fen1;
                    loop.Fen2 += obj.Fen2;
                    loop.Game1 += obj.Game1;
                    loop.Game2 += obj.Game2;
                    if (obj.Game1 > obj.Game2)
                    {
                        loop.Team1++;
                    }
                    else
                    {
                        loop.Team2++;
                    }
                }
            }
            //爱米模式
            if (order.TeamScoreMode == TeamScoreMode.SINGLE_RACE.Id)
            {
                loop.Score1 = order.TeamScoreMode == TeamScoreMode.SINGLE_RACE.Id ? loop.Team1 : Globals.TT_SCORE_WIN;
                loop.Score2 = order.TeamScoreMode == TeamScoreMode.SINGLE_RACE.Id ? loop.Team2 : Globals.TT_SCORE_FAIL;
            }
            else
            {
                if (loop.Team1 > loop.Team2)
                {
                    loop.Score1 = Globals.TT_SCORE_WIN;
                    loop.Score2 = Globals.TT_SCORE_FAIL;
                }
                else if (loop.Team1 < loop.Team2)
                {
                    loop.Score1 = Globals.TT_SCORE_FAIL;
                    loop.Score2 = Globals.TT_SCORE_WIN;
                }
            }
        }

        public void SetWaiver(EntityBase loopObj)
        {
            var loop = (GameLoop)loopObj;
            var order = GameHelper.GetGameOrder(loop.OrderId);
            //爱猕模式
            var isSingleRace = order.TeamScoreMode == TeamScoreMode.SINGLE_RACE.Id;

            if (loop.WaiverOption == WaiverOption.A)
            {
                loop.Score1 = Globals.TT_SCORE_WAIVER;
                loop.Score2 = isSingleRace ? order.WinTeam * 2 - 1 : Globals.TT_SCORE_WIN;
                loop.Team1 = 0;
                loop.Team2 = isSingleRace ? order.WinTeam * 2 - 1 : order.WinTeam;
                loop.Game1 = 0;
                loop.Game2 = loop.Team2 * order.WinGame;
                loop.Fen1 = 0;
                loop.Fen2 = loop.Game2 * Globals.TT_ONE_GAME_FEN;
            }
            else if (loop.WaiverOption == WaiverOption.B)
            {
                loop.Score1 = isSingleRace ? order.WinTeam * 2 - 1 : Globals.TT_SCORE_WIN;
                loop.Score2 = Globals.TT_SCORE_WAIVER;
                loop.Team1 = isSingleRace ? order.WinTeam * 2 - 1 : order.WinTeam;
                loop.Team2 = 0;
                loop.Game1 = loop.Team1 * order.WinGame;
                loop.Game2 = 0;
                loop.Fen1 = loop.Game1 * Globals.TT_ONE_GAME_FEN;
                loop.Fen2 = 0;
            }
            else
            {
                loop.Team1 = 0;
                loop.Team2 = 0;
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
