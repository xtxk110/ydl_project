using System;
using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Core;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 获取机构列表
    /// </summary>
    public class GetOrganizationList : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetSystemManageRelatedFilter>>(request);
            var cmd = CommandHelper.CreateProcedure<CoachOrganization>(text: "sp_GetOrganizationList");
            cmd.Params.Add(CommandHelper.CreateParam("@OrganizationName ", req.Filter.OrganizationName));
            cmd.Params.Add(CommandHelper.CreateParam("@CurrentUserId ", req.Filter.CurrentUserId));
            cmd.CreateParamPager(req.Filter);

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();

            return result;


        }


    }
}
