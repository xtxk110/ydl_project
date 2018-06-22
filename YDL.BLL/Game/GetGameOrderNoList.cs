using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Core;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 获取单循环的的轮次列表
    /// </summary>
    class GetGameOrderNoList_196 : IService
    {
        /// <summary>
        /// 获取单循环的的轮次列表
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<Game>>(request);
            string sqlStr = @"SELECT DISTINCT OrderNo FROM GameLoop WHERE GameId=@GameId ORDER BY OrderNo";
            var cmd = CommandHelper.CreateText<GameLoopOrderNo>(FetchType.Fetch,sqlStr);
            cmd.Params.Add(CommandHelper.CreateParam("@GameId", req.Filter.Id));

            var result = DbContext.GetInstance().Execute(cmd);
            return result;
        }
    }
}
