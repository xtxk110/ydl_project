
using System.Collections.Generic;
using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 获取比赛轮次进度列表
    /// </summary>
    public class GetGameProgressList : IService
    {
        /// <summary>
        /// 获取比赛轮次进度列表
        /// </summary>
        /// <param name="request">Request.Game.Filter</param>
        /// <returns>Response.GameProgress</returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<Game>>(request);

            var cmd = CommandHelper.CreateProcedure<GameProgress>(text: "sp_GetGameProgress");
            cmd.CreateParamId(req.Filter.Id);
            var result = DbContext.GetInstance().Execute(cmd);

            return result;
        }
    }

}
