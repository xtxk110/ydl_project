using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Map;
using YDL.Model;
using Newtonsoft.Json;
using YDL.Core;

namespace YDL.BLL
{
    /// <summary>
    /// 删除机构
    /// </summary>
    class DeleteOrg_196 : IService
    {
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<Organization>>(request);
            var obj = req.FirstEntity();
            Organization org = OrgHelper.GetOrg(obj.TypeId);
            if (org.IsDefault)
            {
                return ResultHelper.Fail("默认机构不能修改");
            }
            var cmd = CommandHelper.CreateProcedure<Organization>(FetchType.Execute, "sp_DeleteOrg");
            cmd.Params.Add("@typeId", obj.TypeId);
            cmd.Params.Add("@parenetTypeId", obj.ParentTypeId);
            return DbContext.GetInstance().Execute(cmd);
        }

    }
}
