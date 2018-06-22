using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Core;
using YDL.Map;
using YDL.Model;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 创建赛事时选择对阵模板列表
    /// </summary>
   public class GetGameTempletList_198: IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GameTeamLoopTempletFilter>>(request);
            Response res = GameLoopTempletHelper.GetTempletList(currentUser.Id, req.Filter.Name, 1);
            return res;
        }
    }
    /// <summary>
    /// 进入我的团体对阵模板页面时调用
    /// </summary>
    public class GetMyTempletList_198 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GameTeamLoopTempletFilter>>(request);
            Response res = GameLoopTempletHelper.GetTempletList(currentUser.Id, req.Filter.Name,2);
            return res;
        }
    }
}
