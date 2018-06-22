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
    /// 设置俱乐部比赛，参与活动者，不一定参加比赛
    /// </summary>
    public class SetGameUserState : IService
    {
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GameTeam>>(request);
            var cmd = CommandHelper.CreateSave(req.Entities);
            cmd.OnlyFields = new List<TableFieldPair> { new TableFieldPair { Table = "GameTeam", Fields = "IsJoined" } };

            return DbContext.GetInstance().Execute(cmd);
        }
    }
}
