
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Utility;
using System.Linq;
using System.Collections.Generic;

namespace YDL.BLL
{
    /// <summary>
    /// 计算单个小组排名（比赛未全部结束则不计算）
    /// </summary>
    public class CalculateGroupRank : IService
    {
        /// <summary>
        /// 计算单个小组排名（比赛未全部结束则不计算）
        /// </summary>
        /// <param name="request">Request.GameGroup.Entities</param>
        /// <returns>Response.EmptyEntity</returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GameGroup>>(request);
            GroupRank rank = new GroupRank();
            var errMsg = rank.Rank(req.Entities.First().Id);

            return errMsg.IsNotNullOrEmpty() ? ResultHelper.Fail(errMsg) : ResultHelper.Success();
        }
    }

}
