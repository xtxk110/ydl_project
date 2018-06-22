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
    /// 购买支付成功入账(done)
    /// </summary>
    public class SaveVipBuyPay : IServiceBase
    {
        /// <summary>
        /// 购买支付成功入账
        /// </summary>
        /// <param name="request">实体VipBuy</param>
        /// <returns></returns>
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<VipBuy>>(request);
            var obj = req.Entities.FirstOrDefault();

            obj.CreatorId = obj.CreatorId.GetId();
            obj.PayOption = obj.PayOption.GetId();
            obj.PayState = obj.PayState.GetId();

            var cmd = CommandHelper.CreateProcedure(FetchType.Execute, "sp_SaveVipBuyPay");
            cmd.Params.Add("@id", obj.Id);
            cmd.Params.Add("@orderNo", null);
            cmd.Params.Add("@amount", obj.Amount, DataType.Decimal);
            cmd.Params.Add("@payOption", obj.PayOption);
            cmd.Params.Add("@payId", obj.PayId);
            cmd.Params.Add("@payState", obj.PayState);
            cmd.Params.Add("@payRemark", obj.PayRemark);
            cmd.CreateParamMsg();

            var result = DbContext.GetInstance().Execute(cmd);


            return result;
        }

    }

}
