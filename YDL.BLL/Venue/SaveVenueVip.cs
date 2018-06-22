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
    /// 保存VIP设置
    /// </summary>
    public class SaveVenueVip : IService
    {
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<Venue>>(request);
            var obj = req.Entities.FirstOrDefault();
            var cmd = CommandHelper.CreateProcedure(FetchType.Execute, "sp_SetVenueVip");
            cmd.CreateParamId(obj.Id);
            cmd.Params.Add("@isVip", obj.IsUseVip, DataType.Boolean);
            cmd.Params.Add("@creditLine", obj.CreditLine, DataType.Double);
            cmd.Params.Add("@balance", obj.Balance, DataType.Double);
            cmd.CreateParamMsg();

            return DbContext.GetInstance().Execute(cmd);
        }
    }

}
