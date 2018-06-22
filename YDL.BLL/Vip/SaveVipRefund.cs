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
    /// 保存退款单
    /// </summary>
    public class SaveVipRefund : IServiceBase
    {
        /// <summary>
        /// 保存退款单
        /// </summary>
        /// <param name="request">实体VipRefund</param>
        /// <returns></returns>
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<VipRefund>>(request);
            var obj = req.Entities.FirstOrDefault();

            obj.SetNewEntity();
            obj.OrderNo = SystemHelper.GetSerialNo(SerialNoType.VipRefund);

            var cmd = CommandHelper.CreateProcedure(FetchType.Execute, "sp_SaveVipRefund");
            cmd.Params.Add("@id", obj.Id);
            cmd.Params.Add("@orderNo", obj.OrderNo);
            cmd.Params.Add("@UserId", obj.UserId);
            cmd.Params.Add("@AppliedAmount", obj.AppliedAmount, DataType.Decimal);
            cmd.Params.Add("@amount", obj.Amount, DataType.Decimal);
            cmd.Params.Add("@CreatorId", obj.CreatorId.GetId());
            cmd.Params.Add("@Remark", obj.Remark);
            cmd.CreateParamMsg();

            return DbContext.GetInstance().Execute(cmd);
        }

    }

}
