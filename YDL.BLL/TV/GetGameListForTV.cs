using System;
using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Core;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 赛事列表
    /// </summary>
    public class GetGameListForTV
    {
        public static Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetGameListFilter>>(request);
            var cmd = CommandHelper.CreateProcedure<Game>(text: "sp_GetGameTVList");
            cmd.Params.Add(CommandHelper.CreateParam("@clubId", req.Filter.ClubId));
            cmd.Params.Add(CommandHelper.CreateParam("@cityId", req.Filter.CityId));
            cmd.Params.Add(CommandHelper.CreateParam("@gameName", req.Filter.GameName));
            cmd.Params.Add(CommandHelper.CreateParam("@isOnlySelf", req.Filter.IsOnlySelf));
            cmd.Params.Add(CommandHelper.CreateParam("@state", req.Filter.State));
            cmd.CreateParamPager(req.Filter);
            cmd.CreateParamUser("001001");//写死超级管理员

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();
            if (result.Entities.IsNotNullOrEmpty())
            {
                foreach (Game obj in result.Entities)
                {
                    GameHelper.SetGameTeamList(obj);
                }
            }

            return result;
        }
    }

}
