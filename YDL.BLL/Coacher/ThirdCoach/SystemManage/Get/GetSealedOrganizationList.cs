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
    /// 获取封闭机构列表
    /// </summary>
    public class GetSealedOrganizationList_189 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetCoachRelatedFilter>>(request);
            var cmd = CommandHelper.CreateProcedure<CoachOrganization>(text: "sp_GetSealedOrganizationList");
            cmd.Params.Add(CommandHelper.CreateParam("@OrganizationName ", req.Filter.OrganizationName));
            cmd.CreateParamPager(req.Filter);

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();

            return result;


        }


    }
}
