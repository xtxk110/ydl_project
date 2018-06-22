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
    /// 获取某人的赛事列表
    /// </summary>
    public class GetSomeoneGameList : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetGameListFilter>>(request);
            var cmd = CommandHelper.CreateProcedure<Game>(text: "sp_GetGameList");
            cmd.Params.Add(CommandHelper.CreateParam("@clubId", req.Filter.ClubId));
            cmd.Params.Add(CommandHelper.CreateParam("@cityId", req.Filter.CityId));
            cmd.Params.Add(CommandHelper.CreateParam("@gameName", req.Filter.GameName));
            cmd.Params.Add(CommandHelper.CreateParam("@isOnlySelf", req.Filter.IsOnlySelf));
            cmd.Params.Add(CommandHelper.CreateParam("@state", req.Filter.State));
            cmd.CreateParamPager(req.Filter);
            cmd.CreateParamUser(req.Filter.UserId);

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();
            var user = UserHelper.GetUserById(req.Filter.UserId);
            if (user != null)
            {
                result.Tag = user.PetName;

            }
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
