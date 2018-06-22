using System;
using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Core;
using YDL.Utility;
using System.Collections.Generic;

namespace YDL.BLL
{
    /// <summary>
    /// 修改集训的状态
    /// </summary>
    public class UpdateCoachBootcampState : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<CoachBootcamp>>(request);
            var obj = req.FirstEntity();
            if (!PermissionCheck.Instance.IsSystemManager(currentUser.Id))
            {
                return ResultHelper.Fail("对不起你没有权限, 只有系统管理员才能更改");
            }

            var sql = @"
UPDATE dbo.CoachBootcamp 
SET State=@State , UpdateDate=@UpdateDate
WHERE Id=@Id
";
            var cmd = CommandHelper.CreateText<CoachBootcamp>(FetchType.Execute, sql);
            cmd.Params.Add("@State", obj.State);
            cmd.Params.Add("@Id", obj.Id);
            cmd.Params.Add("@UpdateDate", DateTime.Now);

            var result = DbContext.GetInstance().Execute(cmd);
            return result;

        }




    }
}
