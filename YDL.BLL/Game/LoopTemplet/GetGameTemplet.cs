using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Map;
using YDL.Model;
using YDL.Utility;
using Newtonsoft.Json;
using YDL.Core;

namespace YDL.BLL
{
    /// <summary>
    /// 获取团体对阵模板规则详情
    /// </summary>
    public class GetGameTemplet_198 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GameTeamLoopTempletFilter>>(request);
            Response res = GameLoopTempletHelper.GetTempletDetail(req.Filter);
            return res;

        }
    }
}
