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
    /// 设置对阵模板的分享状态及分享人
    /// </summary>
    public class SetTempletShareState_198 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GameTeamLoopTemplet>>(request);
            GameTeamLoopTemplet templet = req.FirstEntity();
            var res = GameLoopTempletHelper.SetTempletState(templet, currentUser);
            return res;
        }
    }
}
