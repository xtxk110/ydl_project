
using System.Collections.Generic;
using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Utility;
using YDL.Core;
using System;

namespace YDL.BLL
{
    /// <summary>
    /// 获取悦豆账单列表
    /// </summary>
    public class GetYueDouFlowList_188 : IServiceBase
    {

        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetGuessRelatedFilter>>(request);
            var cmd = CommandHelper.CreateProcedure<YueDouFlow>(text: "GetYueDouFlowList");
            cmd.Params.Add(CommandHelper.CreateParam("@UserId", req.Filter.CurrentUserId));
            cmd.CreateParamPager(req.Filter);

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();
            return result;
        }



    }

}
