using System;
using System.Linq;
using Newtonsoft.Json;
using System.Collections.Generic;
using YDL.Map;
using YDL.Utility;
using YDL.Model;
using YDL.Core;

namespace YDL.BLL
{

    /// <summary>
    /// 获取比赛小组比赛明细
    /// </summary>
    public class GetGameGroupForTV
    {
        public static Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetGameGroupListFilter>>(request);

            var cmd = CommandHelper.CreateProcedure<GameGroup>(FetchType.Fetch, "sp_GetGameGroupList");
            cmd.Params.Add(CommandHelper.CreateParam("@gameId", req.Filter.GameId));
            cmd.Params.Add(CommandHelper.CreateParam("@groupId", req.Filter.GroupId));
            var result = DbContext.GetInstance().Execute(cmd);

            var group = result.FirstEntity<GameGroup>();
            if (req.Filter.IsContainMember)
            {
                GameHelper.SetGroupMemberList(group);
            }
            if (req.Filter.IsContainLoop)
            {
                group.LoopList = GameHelper.GetGroupLoopList(group.Id);
            }

            return result;
        }
    }
}
