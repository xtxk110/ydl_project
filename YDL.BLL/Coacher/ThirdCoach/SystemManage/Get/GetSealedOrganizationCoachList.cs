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
    /// 获取封闭机构下的教练列表
    /// </summary>
    public class GetSealedOrganizationCoachList_189 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetCoachRelatedFilter>>(request);
            var cmd = CommandHelper.CreateProcedure<Coach>(text: "sp_GetSealedOrganizationCoachList");
            cmd.Params.Add(CommandHelper.CreateParam("@CoachName ", req.Filter.Name));
            cmd.Params.Add(CommandHelper.CreateParam("@SealedOrganizationId ", req.Filter.SealedOrganizationId));
            cmd.CreateParamPager(req.Filter);

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();

            return result;


        }


    }
}
