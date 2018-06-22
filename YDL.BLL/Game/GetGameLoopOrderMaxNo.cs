using System;
using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Core;

namespace YDL.BLL
{
    /// <summary>
    /// 获取大循环总轮次
    /// </summary>
    public class GetGameLoopOrderMaxNo : IService
    {
        /// <summary>
        /// 
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetGameOrderLoopListFilter>>(request);
            var cmd = CommandHelper.CreateText<GameLoop>(FetchType.Scalar, text: "SELECT MAX(OrderNo) FROM GameLoop WHERE GameId=@gameId AND GroupId=@groupId");
            cmd.Params.Add(CommandHelper.CreateParam("@gameId", req.Filter.GameId));
            cmd.Params.Add(CommandHelper.CreateParam("@groupId", req.Filter.GroupId));


            var result = DbContext.GetInstance().Execute(cmd);

            return result;
        }

    }

    
}
