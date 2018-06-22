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
    /// 获取机构详情
    /// </summary>
    public class GetOrganization : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetSystemManageRelatedFilter>>(request);
            var sql = @"
 SELECT 
	 a.*,
	 ManagerName =(CASE WHEN ISNULL(b.CardName,'')='' THEN b.PetName ELSE b.CardName END )
 FROM dbo.CoachOrganization a
 LEFT JOIN dbo.UserAccount b ON a.ManagerId=b.Id
 WHERE a.Id =@Id

";
            var cmd = CommandHelper.CreateText<CoachOrganization>(FetchType.Fetch, sql);
            cmd.Params.Add("@Id", req.Filter.OrganizationId);
            var result = DbContext.GetInstance().Execute(cmd);
            return result;

        }


    }
}
