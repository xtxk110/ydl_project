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
    /// 获取封闭机构的集训详情
    /// </summary>
    public class GetSealedBootcamp_189 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetSystemManageRelatedFilter>>(request);
            Response rsp = ResultHelper.CreateResponse();
            CoachBootcamp obj =CoachHelper.Instance.GetCoachBootcampById(req.Filter.CoachBootcampId);
            rsp.Entities.Add(obj);
            return rsp;

        }


       

    }
}
