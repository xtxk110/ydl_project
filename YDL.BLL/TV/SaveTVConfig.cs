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

    public class SaveTVConfig : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<TVConfig>>(request);
            Response result = new Response();
            //解除和其他用户的绑定
            foreach (var item in req.Entities)
            {
                result = DeleteExistsTvConfig(item.TVCode);
                if (result.IsSuccess == false)
                {
                    return ResultHelper.Fail("解除绑定失败");
                }
            }

            //绑定到新的用户
            List<EntityBase> entites = new List<EntityBase>();
            foreach (var obj in req.Entities)
            {
                entites.Add(obj);
                if (obj.RowState == RowState.Added)
                {
                    obj.TrySetNewEntity();
                }

            }

            result = DbContext.GetInstance().Execute(CommandHelper.CreateSave(entites));
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

        //解除这个电视和其他人的绑定
        public Response DeleteExistsTvConfig(string tvCode)
        {
            string sql = " DELETE FROM dbo.TVConfig WHERE TVCode=@TVCode";
            var cmd = CommandHelper.CreateText<ClubUser>(FetchType.Execute, sql);
            cmd.Params.Add("@TVCode", tvCode);

            var result = DbContext.GetInstance().Execute(cmd);
            return result;
        }

    }
}
