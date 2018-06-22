using System;
using System.Text;
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
    /// 保存第一轮淘汰抽签
    /// </summary>
    public class SaveGameLoopTeam : IService
    {
        /// <summary>
        /// 保存第一轮淘汰抽签
        /// </summary>
        /// <param name="currentUser">忽略</param>
        /// <param name="request">Request.GameLoop</param>
        /// <returns>Response.EmptyEntity</returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GameLoop>>(request);
            var cmd = CommandHelper.CreateSave(req.Entities);
            foreach (var loop in req.Entities)
            {
                if (loop.Team1Id.IsNotNullOrEmpty())
                {
                    loop.Team1Id = loop.Team1Id.GetId();
                }
                if (loop.Team2Id.IsNotNullOrEmpty())
                {
                    loop.Team2Id = loop.Team2Id.GetId();
                }
            }
            cmd.OnlyFields = new List<TableFieldPair> { new TableFieldPair { Table = "GameLoop", Fields = "Team1Id,Team2Id" } };

            return DbContext.GetInstance().Execute(cmd);
        }
    }
}
