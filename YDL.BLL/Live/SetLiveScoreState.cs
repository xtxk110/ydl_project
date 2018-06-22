using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Map;
using YDL.Model;

namespace YDL.BLL
{
    /// <summary>
    /// 直播比分显示状态设置
    /// </summary>
    public class SetLiveScoreState_195 : IService
    {
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<Game>>(request);
            var obj = req.FirstEntity();
            var sql = @"
UPDATE dbo.Game 
SET IsEnableLiveScore=@IsEnableLiveScore 
WHERE Id=@Id 
";
            var cmd = CommandHelper.CreateText<Game>(FetchType.Execute, sql);
            cmd.Params.Add("@IsEnableLiveScore", obj.IsEnableLiveScore);
            cmd.Params.Add("@Id", obj.Id);

            var result = DbContext.GetInstance().Execute(cmd);
            return result;
        }
    }
}
