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
    /// 修改教练分成比例
    /// </summary>
    public class UpdateCoachPercentage : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<Coach>>(request);
            var obj = req.FirstEntity();
            var sql = @"
UPDATE Coach 
SET CommissionPercentage=@CommissionPercentage 
WHERE Id=@Id
";
            var cmd = CommandHelper.CreateText<Coach>(FetchType.Execute, sql);
            cmd.Params.Add("@CommissionPercentage", obj.CommissionPercentage);
            cmd.Params.Add("@Id", obj.Id);

            var result = DbContext.GetInstance().Execute(cmd);
            return result;

        }




    }
}
