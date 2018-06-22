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
    /// 设置直播状态
    /// </summary>
    public class SetLiveState_192 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<LiveRoom>>(request);
            var obj = req.FirstEntity();
            var sql = @"
UPDATE dbo.LiveRoom 
SET State=@State  
WHERE Id=@Id 
";
            if (obj.State==LiveDic.Active)
            {
                //直播中断流计数器设置为0
                sql= @"
UPDATE dbo.LiveRoom 
SET State=@State ,NotPushCount=0 
WHERE Id=@Id 
";
                //通过腾讯API接口开启对应直播码且关闭的的直播房间,解决同一直播ID房间关闭再次创建房间无法正常推流问题
                try { CloseBlackScreenLiveSchedule.CheckLiveIsNotPush(obj, true);   
                }
                catch (Exception e) { }
                

            }
     
            var cmd = CommandHelper.CreateText<LiveRoom>(FetchType.Execute, sql);
            cmd.Params.Add("@Id", obj.Id);
            cmd.Params.Add("@State", obj.State);

            var result = DbContext.GetInstance().Execute(cmd);
            if (obj.State == LiveDic.Active)
            {
                //直播状态变为"Active"时，打开直播黑屏检测计时器
                CloseBlackScreenLiveSchedule.StartTimer();
            }
                

            return result;
        }

        
    }

}
