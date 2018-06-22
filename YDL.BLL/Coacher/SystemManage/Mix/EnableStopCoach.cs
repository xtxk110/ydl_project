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
    /// 启用停用教练
    /// </summary>
    public class EnableStopCoach : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<Coach>>(request);
            var obj = req.FirstEntity();
            var sql = @"
UPDATE Coach 
SET IsEnabled=@IsEnabled 
WHERE Id=@Id
";
            var cmd = CommandHelper.CreateText<Coach>(FetchType.Execute, sql);
            cmd.Params.Add("@IsEnabled", obj.IsEnabled);
            cmd.Params.Add("@Id", obj.Id);

            var result = DbContext.GetInstance().Execute(cmd);
            return result;

        }




    }
}
