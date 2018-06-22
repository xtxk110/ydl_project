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
    /// 取消未支付的消费记录(done)
    /// </summary>
    public class CancelVipUse : IServiceBase
    {
        /// <summary>
        /// 取消未支付的消费记录
        /// </summary>
        /// <param name="request">实体VipBuy</param>
        /// <returns></returns>
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<VipUse>>(request);
            var obj = req.Entities.FirstOrDefault();

            var cmd = CommandHelper.CreateProcedure(FetchType.Execute, "sp_CancelVipUse");
            cmd.Params.Add("@id", obj.Id);
            cmd.CreateParamMsg();

            return DbContext.GetInstance().Execute(cmd);
        }

    }

}
