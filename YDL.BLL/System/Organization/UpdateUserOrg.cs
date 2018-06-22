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
    /// 通过用户更改所属组织机构
    /// </summary>
    class UpdateUserOrg_196 : IService
    {
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<OrganizationUser>>(request);
            var obj = req.FirstEntity();
            string sqlStr = @"UPDATE UserAccount SET OrganTypeId=@typeid WHERE Id=@userid";
            var cmd = CommandHelper.CreateText(FetchType.Execute, sqlStr);
            cmd.Params.Add("@userid",obj.UserId );
            cmd.Params.Add("@typeid", obj.OrgTypeId);
            return DbContext.GetInstance().Execute(cmd);
        }
    }
}
