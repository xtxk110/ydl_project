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
    /// 设置直播对阵
    /// </summary>
    public class SetLiveVS_192 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<LiveRoom>>(request);
            var obj = req.FirstEntity();
            var sql = @"
UPDATE dbo.LiveRoom 
SET VsOrderId=@VsOrderId , VsGameLoopId=@VsGameLoopId
WHERE Id=@Id
";
            var cmd = CommandHelper.CreateText<LiveRoom>(FetchType.Execute, sql);
            cmd.Params.Add("@VsOrderId", obj.VsOrderId);
            cmd.Params.Add("@VsGameLoopId", obj.VsGameLoopId);
            cmd.Params.Add("@Id", obj.Id);

            var result = DbContext.GetInstance().Execute(cmd);
            return result;
        }

        
    }

}
