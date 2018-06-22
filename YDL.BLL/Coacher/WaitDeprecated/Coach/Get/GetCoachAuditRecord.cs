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
    /// 获取教练审核纪录
    /// </summary>
    public class GetCoachAuditRecord : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetCoachRelatedFilter>>(request);

            var coachApply = GetCoachApplyAuditState(req.Filter.CoachId);
            if (coachApply.Entities.Count > 0)
            {
                return coachApply;
            }
            else
            {
                var coach = GetCoachAuditState(req.Filter.CoachId);
                if (coach.Entities.Count > 0)
                {
                    return coach;
                }
                else
                {
                    Response rsp = new Response();
                    rsp.IsSuccess = false;
                    rsp.Message = "没有审核纪录";
                    rsp.ErrorCode = ErrorCode.DATA_NOTEXIST;
                    return rsp;
                }
            }


        }

        public Response GetCoachApplyAuditState(string Id)
        {

            var sql = @"
 SELECT * FROM dbo.CoachApply WHERE Id =@Id
";
            var cmd = CommandHelper.CreateText<Coach>(FetchType.Fetch, sql);
            cmd.Params.Add("@Id", Id);
            var result = DbContext.GetInstance().Execute(cmd);
            return result;
        }

        public Response GetCoachAuditState(string Id)
        {

            var sql = @"
 SELECT * FROM dbo.Coach WHERE Id =@Id
";
            var cmd = CommandHelper.CreateText<Coach>(FetchType.Fetch, sql);
            cmd.Params.Add("@Id", Id);
            var result = DbContext.GetInstance().Execute(cmd);
            return result;
        }
    }
}
