using System;
using System.Collections.Generic;
using System.Linq;

using YDL.Model;

namespace YDL.BLL
{
    /// <summary>
    /// 计算场次得分
    /// </summary>
    public class CalScore : CalBase
    {
        public void Cal(GameGroupMember obj, List<String> players, List<GameLoop> scores)
        {
            obj.Score = 0;
            obj.WinScore = 0;
            obj.LoseScore = 0;

            foreach (var item in scores.Where(p => (p.Team1Id == obj.TeamId && players.Contains(p.Team2Id)
                || p.Team2Id == obj.TeamId && players.Contains(p.Team1Id))))
            {
                obj.Score += (obj.TeamId == item.Team1Id ? item.Score1 : item.Score2);
            }
        }

        public CalBase NextCal(bool isTeam)
        {     
            if (isTeam)
                return new CalTeam();
            else
                return new CalGame();
        }
    }
}
