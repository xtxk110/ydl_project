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
    /// 设置赛事的TV是否启用
    /// </summary>
    public class SetGameTVIsEnabled_191: IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<Game>>(request);
            var obj = req.FirstEntity();
            var sql = @"
UPDATE dbo.Game 
SET IsEnableTV=@IsEnableTV 
WHERE Id=@Id 
";
            var cmd = CommandHelper.CreateText<ClubUser>(FetchType.Execute, sql);
            cmd.Params.Add("@IsEnableTV", obj.IsEnableTV);
            cmd.Params.Add("@Id", obj.Id);

            var result = DbContext.GetInstance().Execute(cmd);
            result.Tag = UserHelper.GetConfig().SocketIpAndPort;
            return result;
        }

    }

}
