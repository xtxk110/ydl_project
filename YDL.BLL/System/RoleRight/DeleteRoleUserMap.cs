using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Core;
using YDL.Map;
using YDL.Model;

namespace YDL.BLL
{
    /// <summary>
    ///  用户角色删除(从角色删除某个用户)
    /// </summary>
    public class DeleteRoleUserMap_196 : IService
    {
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<LimitRole>>(request);
            var obj = req.FirstEntity();
            string sqlStr = @"DELETE FROM LimitRoleUserMap WHERE UserId=@userid AND RoleId=@roleid";
            var cmd1 = CommandHelper.CreateText<LimitRole>(FetchType.Execute, sqlStr);
            cmd1.Params.Add("@roleid", obj.Id);
            cmd1.Params.Add("@userid", obj.UserId);
            var response= DbContext.GetInstance().Execute(cmd1);
            LimitHelper.DeleteOnlieUser(obj.UserId);//剔除对应在线用户
            return response;
        }
    }
}
