using System;
using System.Linq;
using System.Text.RegularExpressions;
using Newtonsoft.Json;
using System.Collections.Generic;
using YDL.Map;
using YDL.Utility;
using YDL.Model;
using YDL.Core;

namespace YDL.BLL
{
    /// <summary>
    /// 获取桌子状态
    /// </summary>
    public class GetGameTableList : IService
    {
        /// <summary>
        /// 获取桌子状态
        /// </summary>
        /// <param name="currentUser">忽略</param>
        /// <param name="request">Request.GetGameTableListFilter.Filter</param>
        /// <returns>Response.GameTable</returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetGameTableListFilter>>(request);

            var cmd = CommandHelper.CreateProcedure<GameTable>(FetchType.Fetch, "sp_GetGameTableList");
            cmd.Params.Add(CommandHelper.CreateParam("@gameId", req.Filter.GameId));
            cmd.Params.Add(CommandHelper.CreateParam("@beginTime", req.Filter.CurrentTime));
            var result = DbContext.GetInstance().Execute(cmd);

            if (result.Entities.IsNotNullOrEmpty())
            {
                var listLoop = result.Entities.ToList<EntityBase, GameTable>();
                //添加未存在的桌号，保持连续性
                for (int i = 1, max = listLoop.Max(p => p.No); i < max; i++)
                {
                    var table = listLoop.FirstOrDefault(p => p.No == i);
                    if (table == null)
                    {
                        result.Entities.Insert(i - 1, new GameTable { No = i, IsEmpty = true });
                    }
                }
            }

            return result;
        }

        private static bool IsInteger(string s)
        {
            string pattern = @"^\d*$";
            return Regex.IsMatch(s, pattern);
        }

    }
}
