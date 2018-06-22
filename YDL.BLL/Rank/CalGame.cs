using System;
using System.Collections.Generic;
using System.Linq;

using YDL.Model;

namespace YDL.BLL
{
    /// <summary>
    /// 计算胜负局比率
    /// </summary>
    public class CalGame : CalBase
    {
        public void Cal(GameGroupMember obj, List<String> players, List<GameLoop> scores)
        {
            obj.Score = 0;
            obj.WinScore = 0;
            obj.LoseScore = 0;

            foreach (var item in scores.Where(p => (p.Team1Id == obj.TeamId && players.Contains(p.Team2Id)
                || p.Team2Id == obj.TeamId && players.Contains(p.Team1Id))))
            {
                obj.WinScore += (obj.TeamId == item.Team1Id ? item.Game1 : item.Game2);
                obj.LoseScore += (obj.TeamId == item.Team1Id ? item.Game2 : item.Game1);
            }
            obj.Score = obj.WinScore / (obj.LoseScore == 0 ? 1 : obj.LoseScore);
        }

        public CalBase NextCal(bool isTeam)
        {
            return new CalFen();
        }
    }
}
