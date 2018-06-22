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
    /// 修改小组排名
    /// </summary>
    public class SaveGameGroupRank : IService
    {
        /// <summary>
        /// 修改小组排名
        /// </summary>
        /// <param name="currentUser">忽略</param>
        /// <param name="request">Request.GameGroupMember</param>
        /// <returns>Response.EmptyEntity</returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GameGroupMember>>(request);
            var cmd = CommandHelper.CreateSave(req.Entities);
            cmd.OnlyFields = new List<TableFieldPair> { new TableFieldPair { Table = "GameGroupMember", Fields = "Rank" } };

            return DbContext.GetInstance().Execute(cmd);
        }
    }
}
