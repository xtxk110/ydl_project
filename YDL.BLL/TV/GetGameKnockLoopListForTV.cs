using System;
using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Core;
using YDL.Utility;
using System.Collections.Generic;

namespace YDL.BLL
{
    /// <summary>
    /// 获取淘汰进度图数据
    /// </summary>
    public class GetGameKnockLoopListForTV
    {

        public static Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<Game>>(request);
            var cmd = CommandHelper.CreateProcedure<GameLoop>(text: "sp_GetGameKnockLoopList");
            cmd.Params.Add(CommandHelper.CreateParam("@gameId", req.Filter.Id));
            cmd.Params.Add(CommandHelper.CreateParam("@knockOutAB", req.Filter.KnockOutAB.IsNullOrEmpty() ? KnockOutAB.A : req.Filter.KnockOutAB));

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();

           
            List<GameLoop> loopList = GetLoopListByGameId(req.Filter.Id);//首先获取所有对阵数据
            // 获取3,4名数据
            var obj = GetRank(loopList, 3, 4);
            if (obj != null)
            {
                //重新计算Game1 和Game2 的值
                if (obj.IsTeam)
                {
                    obj.Game1 = obj.Team1;
                    obj.Game2 = obj.Team2;
                }
                
                result.Entities.Add(obj);
            }
            return result;
        }

        /// <summary>
        /// 获取对阵连续2名数据(比如3,4名;5,6名);1,2名直接在决赛取,附加赛里没有
        /// </summary>
        /// <param name="loopList"></param>
        /// <param name="beginRank">排名前一位</param>
        /// <param name="endRank">排名后一位</param>
        /// <returns></returns>
        public static GameLoop GetRank(List<GameLoop> loopList,int beginRank,int endRank)
        {
            if (beginRank <= 2 || endRank <= beginRank)
                return null;
            var obj = loopList.ToList<EntityBase, GameLoop>().Where(e => e.IsExtra == true && e.EndRank==endRank&&e.BeginRank==beginRank).FirstOrDefault();
            return obj;
        }
        /// <summary>
        /// 根据赛事ID,获取所有对阵数据
        /// </summary>
        /// <param name="GameId"></param>
        /// <returns></returns>
        private static List<GameLoop> GetLoopListByGameId(string GameId)
        {
            var cmd = CommandHelper.CreateProcedure<GameLoop>(text: "sp_GetGameOrderLoopList");
            cmd.Params.Add(CommandHelper.CreateParam("@gameId", GameId));
            cmd.Params.Add(CommandHelper.CreateParam("@knockOutAB", ""));
            cmd.Params.Add(CommandHelper.CreateParam("@orderId", ""));
            cmd.Params.Add(CommandHelper.CreateParam("@groupId", ""));
            cmd.Params.Add(CommandHelper.CreateParam("@isExtra", ""));
            cmd.Params.Add(CommandHelper.CreateParam("@groupOrderNo", 0));
            cmd.Params.Add(CommandHelper.CreateParam("@orderNo", 0));//20180326  zq
            cmd.Params.Add(CommandHelper.CreateParam("@startTime", ""));
            cmd.Params.Add(CommandHelper.CreateParam("@endTime", ""));
            cmd.Params.Add(CommandHelper.CreateParam("@team1Id", ""));
            cmd.Params.Add(CommandHelper.CreateParam("@team2Id", ""));
            cmd.Params.Add(CommandHelper.CreateParam("@tableNo", 0));

            var result = DbContext.GetInstance().Execute(cmd);
            return result.Entities.ToList<EntityBase, GameLoop>();
        }
    }
}
