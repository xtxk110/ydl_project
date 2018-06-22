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
    /// 自动创建测试参赛队伍
    /// </summary>
    public class AutoCreateTestGameTeam : IService
    {
        /// <summary>
        /// 自动创建测试参赛队伍
        /// </summary>
        /// <param name="currentUser">忽略</param>
        /// <param name="request">Request.Game</param>
        /// <returns>Response.EmptyEntity</returns>
        public Response Execute(string request)
        {
            var app = UserHelper.GetAppVersion();
            if (app.IsRelease)
            {
                return ResultHelper.Fail("本功能只能在测试数据库使用。");
            }

            var req = JsonConvert.DeserializeObject<Request<Game>>(request);

            var cmd = CommandHelper.CreateProcedure(FetchType.Execute, "sp_AutoCreateTestGameTeam");
            cmd.Params.Add("@gameId", req.Filter.Id);

            var result = DbContext.GetInstance().Execute(cmd);

            return result;
        }
    }
}
