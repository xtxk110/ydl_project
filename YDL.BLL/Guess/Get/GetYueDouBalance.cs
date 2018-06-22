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
    /// 获取悦豆余额
    /// </summary>
    public class GetYueDouBalance_188 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetGuessRelatedFilter>>(request);
            Response rsp = ResultHelper.CreateResponse();
            rsp.IsSuccess = true;
            rsp.Entities.Add(GuessHelper.Instance.GetYueDouBalance(req.Filter.CurrentUserId));
            return rsp;
        }


    }
}
