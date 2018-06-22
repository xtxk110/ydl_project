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
    /// 设置活动状态
    /// </summary>
    public class SaveActivityState : IServiceBase
    {
        /// <summary>
        /// 取消活动
        /// </summary>
        /// <param name="currentUser"></param>
        /// <param name="request">Request<Activity></param>
        /// <returns>Response<EmptyEntity></returns>
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<Activity>>(request);
            var activity = req.Entities.FirstOrDefault();
            activity.State = activity.State.GetId();
            var cmd = CommandHelper.CreateProcedure(FetchType.Execute, "sp_SetActivityState");
            cmd.CreateParamId(activity.Id);
            cmd.Params.Add("@state",activity.State);

            return DbContext.GetInstance().Execute(cmd);
        }
    }
}
