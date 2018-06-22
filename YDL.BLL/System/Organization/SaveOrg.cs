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
    /// 增加机构
    /// </summary>
    class SaveOrg_196 : IService
    {
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<Organization>>(request);
            var obj = req.FirstEntity();
            if (string.IsNullOrEmpty(obj.ParentTypeId))
            {
                return ResultHelper.Fail("上级机构TypeId不能为空");
            }
            if (obj.ParentTypeId == "00000")
            {
                return ResultHelper.Fail("不能添加顶级机构");
            }
            string newTypeId = OrgHelper.GetNewOrgTypeid(obj.ParentTypeId, OrgHelper.GetSonCounter(obj.ParentTypeId));
            var cmd = CommandHelper.CreateProcedure<Organization>(FetchType.Execute, "sp_SaveOrg");
            cmd.Params.Add("@name", obj.Name);
            cmd.Params.Add("@typeId", newTypeId);
            cmd.Params.Add("@parenetTypeId", obj.ParentTypeId);
            return DbContext.GetInstance().Execute(cmd);
        }
    }
}
