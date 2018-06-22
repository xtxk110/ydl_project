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
    /// 创建一轮附加赛
    /// </summary>
    class ExtraGame
    {
        int extraOrder = 0;

        public int Create(int userCount, List<EntityBase> entities, GameOrder order, int beginRank, int endRank)
        {
            extraOrder++;
            int currentOrder = extraOrder;

            //创建本轮所有比赛
            var tempList = new List<GameLoop>();
            for (int i = 0; i < userCount; i = i + 2)
            {
                GameLoop loop = CreateExtraLoop(order, beginRank, endRank, currentOrder, i);
                entities.Add(loop);
                tempList.Add(loop);
            }

            int winOrder = 0;
            int failOrder = 0;
            if (userCount > 2)
            {
                int rankCount = (endRank + 1 - beginRank) / 2;
                //递归创建负者赛
                failOrder = Create(userCount / 2, entities, order, endRank - rankCount + 1, endRank);
                //递归创建胜者赛
                winOrder = Create(userCount / 2, entities, order, beginRank, beginRank + rankCount - 1);
            }
            foreach (var obj in tempList)
            {
                obj.ExtraWinOrder = winOrder;
                obj.ExtraFailOrder = failOrder;
            }

            return currentOrder;
        }

        private static GameLoop CreateExtraLoop(GameOrder order, int beginRank, int endRank, int currentOrder, int i)
        {
            GameLoop loop = new GameLoop();
            loop.SetNewId();
            loop.SetCreateDate();
            loop.SetRowAdded();

            loop.OrderId = order.Id;//正常大轮次
            loop.OrderNo = (i + 2) / 2;//序号
            loop.GameId = order.GameId;
            loop.GroupId = null;
            loop.Team1Id = null;
            loop.Team2Id = null;
            loop.BeginRank = beginRank;
            loop.EndRank = endRank;
            loop.IsTeam = order.IsTeam;
            loop.State = GameLoopState.NOTSTART.Id;
            loop.IsBye = false;
            loop.IsExtra = true;
            loop.ExtraOrder = currentOrder;
            loop.Remark = string.Format("附加赛 第{0}-{1}名", beginRank, endRank);
            return loop;
        }
    }
}
