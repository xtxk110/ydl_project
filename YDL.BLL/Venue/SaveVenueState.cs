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
    /// 保存场馆状态
    /// </summary>
    public class SaveVenueState : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<Venue>>(request);
            var obj = req.Entities.FirstOrDefault();

            obj.State = obj.State.GetId();

            var cmd = CommandHelper.CreateText(FetchType.Execute, "UPDATE Venue SET State=@state WHERE Id=@id");
            cmd.CreateParamId(obj.Id);
            cmd.Params.Add("@state", obj.State);

            return DbContext.GetInstance().Execute(cmd);
        }
    }

}
