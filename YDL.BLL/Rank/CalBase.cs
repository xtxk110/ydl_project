using System;
using System.Collections.Generic;

using YDL.Model;

namespace YDL.BLL
{
    /// <summary>
    /// 计算策略基类
    /// </summary>
    public interface CalBase
    {
        //本步策略计算排名
        void Cal(GameGroupMember obj, List<String> players, List<GameLoop> scores);

        //下一步计算策略
        CalBase NextCal(bool isTeam);
    }
}
