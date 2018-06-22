using System;
using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Core;
using YDL.Utility;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace YDL.BLL
{

    public class DeleteTVConfig : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<TVConfig>>(request);
            var obj = req.FirstEntity();
            var sql = @"DELETE FROM dbo.TVConfig WHERE UserCode=@UserCode";
            var cmd = CommandHelper.CreateText<ClubUser>(FetchType.Execute, sql);
            cmd.Params.Add("@UserCode", obj.UserCode);

            var result = DbContext.GetInstance().Execute(cmd);
            if (result.IsSuccess)
            {
                //发个消息给SocketServer 服务器更新配置缓存
                Task.Factory.StartNew(NotifySocketServerRefreshCache, TaskCreationOptions.LongRunning);
            }
            return result;

        }
        public void NotifySocketServerRefreshCache()
        {
            SocketClient.SendRefreshCacheMsg();
        }


    }
}
