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
    class MapWaiver : IWaiver
    {
        public void SetScore(EntityBase mapObj)
        {
            var loop = (GameLoopMap)mapObj;
            loop.Fen1 = 0;
            loop.Fen2 = 0;
            loop.Game1 = 0;
            loop.Game2 = 0;
            if (loop.DetailList.IsNotNullOrEmpty())
            {
                TotalDetail(loop);
            }
            loop.SetRowModified();
        }

        private static void TotalDetail(GameLoopMap loop)
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

        public void SetWaiver(EntityBase mapObj)
        {
            var map = (GameLoopMap)mapObj;
            var order = GameHelper.GetGameOrderByLoop(map.LoopId);
            //取胜局（乒超团队模式每场胜局不一样）
            var winGame = map.WinGame > 0 ? map.WinGame : order.WinGame;
            if (map.WaiverOption == WaiverOption.A)
            {
                map.Game1 = 0;
                map.Game2 = winGame;
                map.Fen1 = 0;
                map.Fen2 = winGame * Globals.TT_ONE_GAME_FEN;
            }
            else if (map.WaiverOption == WaiverOption.B)
            {
                map.Game1 = winGame;
                map.Game2 = 0;
                map.Fen1 = winGame * Globals.TT_ONE_GAME_FEN;
                map.Fen2 = 0;
            }
            else
            {
                map.Game1 = 0;
                map.Game2 = 0;
                map.Fen1 = 0;
                map.Fen2 = 0;
            }
        }
    }
}
