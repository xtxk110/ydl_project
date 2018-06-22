using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;

namespace YDL.BLL
{
    /// <summary>
    /// 获取队伍排名,筛选轮次,只针对单循环比赛
    /// </summary>
    class GetGameRankListByOrder_196 : IService
    {
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GameRankFilter>>(request);
            Game game = GameHelper.GetSingleGame(req.Filter.GameId);
            if (game == null || game.KnockoutOption != KnockoutOption.ROUND.Id)
               return  ResultHelper.Fail("此比赛不是单循环模式");

            var cmd = CommandHelper.CreateProcedure<GameTeam>(text: "sp_GetGameRankListByOrder");
            cmd.Params.Add("@gameId", req.Filter.GameId);
            cmd.Params.Add("@startOrderNo", req.Filter.StartOrderNo);
            cmd.Params.Add("@endOrderNo", req.Filter.EndOrderNo);
            var result = DbContext.GetInstance().Execute(cmd);
            return result;
        }
    }
}
