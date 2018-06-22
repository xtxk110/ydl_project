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
    /// 修改俱乐部成员档位
    /// </summary>
    public class SaveClubUserLevel : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<ClubUser>>(request);
            var obj = req.FirstEntity();


            var sql = @"
UPDATE ClubUser 
SET LevelValue=@LevelValue  
WHERE ClubId=@ClubId AND UserId=@UserId
";
            var cmd = CommandHelper.CreateText(FetchType.Execute, sql);
            cmd.Params.Add("@ClubId", obj.ClubId);
            cmd.Params.Add("@UserId", obj.UserId);
            cmd.Params.Add("@LevelValue", obj.LevelValue);
            var result = DbContext.GetInstance().Execute(cmd);

            if (result.IsSuccess)
            {
                try
                {
                    var msg = obj.LevelValue == 0 ? "您被设置为暂不定档。" : string.Format("您被设置为第{0}档", obj.LevelValue);
                    JPushHelper.SendNotify(MasterType.CLUB.Id, obj.ClubId, msg, new List<string> { obj.UserId });
                }
                catch (Exception)
                {
                }
            }
            
            return result;
        }
    }

}
