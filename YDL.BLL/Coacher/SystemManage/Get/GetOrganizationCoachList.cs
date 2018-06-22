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
    /// 获取机构教练列表
    /// </summary>
    public class GetOrganizationCoachList : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetSystemManageRelatedFilter>>(request);
            var sql = @"
 SELECT 
	 b.HeadUrl,
	 b.Sex,
	 a.Grade,
	 Name=dbo.fn_GetUserName(b.Id),
	 b.Code,
	 a.IsEnabled,
	 a.CommissionPercentage,
     a.Id
 FROM dbo.Coach a
 INNER JOIN dbo.UserAccount b ON a.Id=b.Id
 WHERE a.OrganizationId=@OrganizationId
";
            var cmd = CommandHelper.CreateText<Coach>(FetchType.Fetch, sql);
            cmd.Params.Add("@OrganizationId", req.Filter.OrganizationId);
            var result = DbContext.GetInstance().Execute(cmd);
            return result;

        }


    }
}
