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
    /// 获取教练审核列表
    /// </summary>
    public class GetCoachAuditList : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetSystemManageRelatedFilter>>(request);
            var cmd = CommandHelper.CreateProcedure<Coach>(text: "sp_GetCoachAuditList");
            cmd.Params.Add(CommandHelper.CreateParam("@Name", ""));
            cmd.Params.Add(CommandHelper.CreateParam("@State", req.Filter.CoachState));
            cmd.CreateParamPager(req.Filter);

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();
            if (req.Filter.CoachState == AuditState.PROCESSING.Id)
            {
                foreach (var item in result.Entities)
                {
                    var obj = item as Coach;
                    obj.AuditDateTime = (DateTime)obj.CreateDate;
                }
            }
            return result;


        }




    }
}
