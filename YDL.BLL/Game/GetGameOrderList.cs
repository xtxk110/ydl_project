using System;
using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Core;

namespace YDL.BLL
{
    /// <summary>
    /// 获取比赛大轮次表
    /// </summary>
    public class GetGameOrderList : IService
    {
        /// <summary>
        /// 获取比赛大轮次表
        /// </summary>
        /// <param name="currentUser">忽略</param>
        /// <param name="request">Request.Game.Filter</param>
        /// <returns>Response.GameOrder</returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<Game>>(request);
            var cmd = CommandHelper.CreateProcedure<GameOrder>(text: "sp_GetGameOrderList");
            cmd.Params.Add(CommandHelper.CreateParam("@GameId", req.Filter.Id));

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();
            result.Tag = GameHelper.GetGame(req.Filter.Id).State;

            var first = result.FirstEntity<GameOrder>();
            if (first != null)
            {
                if (first.KnockoutOption == KnockoutOption.ROUND.Id)
                {
                    first.GroupList = GameHelper.GetOrderGroupList(first.Id);
                }
            }

            return result;
        }

    }
}
