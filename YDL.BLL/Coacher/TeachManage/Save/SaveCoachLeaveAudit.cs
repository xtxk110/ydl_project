using System;
using System.Linq;
using System.Collections.Generic;

using Newtonsoft.Json;
using YDL.Core;
using YDL.Map;
using YDL.Model;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 保存教练请假审核
    /// </summary>
    public class SaveCoachLeaveAudit_187 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<CoachLeave>>(request);
            var obj = req.FirstEntity();
            var sql = @"
UPDATE CoachLeave 
SET State=@State 
WHERE Id=@Id 
";
            var cmd = CommandHelper.CreateText<CoachLeave>(FetchType.Execute, sql);
            cmd.Params.Add("@State", obj.State);
            cmd.Params.Add("@Id", obj.Id);

            var result = DbContext.GetInstance().Execute(cmd);
            return result;
        }

    }

}
