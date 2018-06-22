using System;
using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Core;
using YDL.Utility;
using System.Collections.Generic;

namespace YDL.BLL
{
    /// <summary>
    /// 获取教练请假列表
    /// </summary>
    public class GetCoachLeaveList_187 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetCoachRelatedFilter>>(request);
            var cmd = CommandHelper.CreateProcedure<CoachLeave>(text: "GetCoachLeaveList");
            cmd.Params.Add(CommandHelper.CreateParam("@CoachId", req.Filter.CurrentUserId));
            cmd.CreateParamPager(req.Filter);

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();

            return result;

        }
         
    }
}
