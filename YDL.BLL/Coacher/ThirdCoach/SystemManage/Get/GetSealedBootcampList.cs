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
    /// 获取封闭机构的集训班列表
    /// </summary>
    public class GetSealedBootcampList_189 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetCoachRelatedFilter>>(request);
            var cmd = CommandHelper.CreateProcedure<CoachBootcamp>(text: "sp_GetSealedBootcampList");
            cmd.Params.Add(CommandHelper.CreateParam("@BootcampName", req.Filter.BootcampName));
            cmd.Params.Add(CommandHelper.CreateParam("@SealedOrganizationId", req.Filter.SealedOrganizationId));

            cmd.CreateParamPager(req.Filter);

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();

            return result;
        }


    }
}
