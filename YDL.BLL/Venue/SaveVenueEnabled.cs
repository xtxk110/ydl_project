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
    /// 保存场馆启用停用
    /// </summary>
    public class SaveVenueEnabled_187 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<Venue>>(request);
            var obj = req.Entities.FirstOrDefault();
            
            var cmd = CommandHelper.CreateText(FetchType.Execute, @"
UPDATE Venue SET IsEnabled=@IsEnabled WHERE Id=@Id
");
            cmd.CreateParamId(obj.Id);
            cmd.Params.Add("@IsEnabled", obj.IsEnabled);
            cmd.Params.Add("@Id", obj.Id);

            return DbContext.GetInstance().Execute(cmd);
        }
    }

}
