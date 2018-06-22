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
    /// 保存竞猜结束
    /// </summary>
    public class SaveGuessEnd_188 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<Guess>>(request);
            var obj = req.FirstEntity();
            var sql = @"
UPDATE dbo.Guess SET EndTime=@EndTime WHERE Id=@Id
";
            var cmd = CommandHelper.CreateText<ClubUser>(FetchType.Execute, sql);
            cmd.Params.Add("@EndTime", DateTime.Now.AddMinutes(-1));//减一分钟让它自然过期, 进而竞猜变成已结束
            cmd.Params.Add("@Id", obj.Id);

            var result = DbContext.GetInstance().Execute(cmd);
            return result;
        }



    }
}
