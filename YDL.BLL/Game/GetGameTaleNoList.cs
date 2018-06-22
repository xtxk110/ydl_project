using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Core;
namespace YDL.BLL
{
    /// <summary>
    /// 获取此赛事的所有球桌号
    /// </summary>
    class GetGameTaleNoList_196 : IService
    {
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<Game>>(request);
            string sqlStr = @"SELECT DISTINCT TableNo AS No FROM GameLoop WHERE GameId=@GameId";
            var cmd = CommandHelper.CreateText<GameTable>(FetchType.Fetch,sqlStr);
            cmd.Params.Add(CommandHelper.CreateParam("@GameId", req.Filter.Id));
            var result = DbContext.GetInstance().Execute(cmd);
            return result;
        }
    }
}
