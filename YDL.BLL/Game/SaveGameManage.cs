using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 赛事管理设置
    /// </summary>
    class SaveGameManage : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<Game>>(request);
            var obj = req.Entities.FirstOrDefault();
            string sqlStr = @"UPDATE Game SET AuditId=@audit,ManageId=@manage WHERE Id=@id";
            var cmd = CommandHelper.CreateText<Game>(FetchType.Execute,sqlStr);
            cmd.Params.Add("@audit", obj.AuditId);
            cmd.Params.Add("@manage", obj.ManageId);
            cmd.Params.Add("@id", obj.Id);
            var result = DbContext.GetInstance().Execute(cmd);
            return result;
        }
    }
}
