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
    /// 保存小组裁判桌号
    /// </summary>
    public class SaveGameGroupLeader : IService
    {
        /// <summary>
        /// 保存小组裁判桌号
        /// </summary>
        /// <param name="currentUser">忽略</param>
        /// <param name="request">Request.GameGroup</param>
        /// <returns>Response.EmptyEntity</returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GameGroup>>(request);
            var cmdSave = CommandHelper.CreateProcedure(FetchType.Execute, "sp_SaveGameGroupLeader");
            cmdSave.Params.Add("@groupId", req.Filter.Id);
            cmdSave.Params.Add("@leaderId", req.Filter.LeaderId);
            cmdSave.Params.Add("@tableNo", req.Filter.TableNo);

            return DbContext.GetInstance().Execute(cmdSave);
        }
    }
}
