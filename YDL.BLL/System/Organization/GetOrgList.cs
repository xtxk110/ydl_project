using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Map;
using YDL.Model;
using Newtonsoft.Json;

namespace YDL.BLL
{
    /// <summary>
    /// 获取机构列表
    /// </summary>
    public class GetOrgList_196 : IService
    {
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<OrganizationFilter>>(request);
            var obj = req.Filter;
            var cmd = CommandHelper.CreateProcedure<Organization>(FetchType.Fetch, "sp_GetOrgList");
            cmd.CreateParamPager(obj);
            var response = DbContext.GetInstance().Execute(cmd);

            foreach(Organization item in response.Entities)
            {
                item.Level = OrgHelper.GetOrgLevel(item.TypeId);
            }
            return response;
        }
        
    }
}
