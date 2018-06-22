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
    /// 修改机构名称
    /// </summary>
    class UpdateOrg_196 : IService
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
            string sqlStr = @"UPDATE Organization SET Name=@name WHERE TypeId=@typeid";
            //obj.RowState = Core.RowState.Modified;
            //List<EntityBase> entities = new List<EntityBase>();
            //entities.Add(obj);
            //var cmd = CommandHelper.CreateSave(entities);
            var cmd = CommandHelper.CreateText<Organization>(FetchType.Execute, sqlStr);
            cmd.Params.Add("@name", obj.Name);
            cmd.Params.Add("@typeid", obj.TypeId);
            return DbContext.GetInstance().Execute(cmd);
        }
    }
    
}
