﻿using System;
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
    /// 消费支付成功入账
    /// </summary>
    public class SaveVipUsePay : IServiceBase
    {
        /// <summary>
        /// 消费支付成功入账
        /// </summary>
        /// <param name="request">实体VipUse</param>
        /// <returns></returns>
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<VipUse>>(request);
            var obj = req.Entities.FirstOrDefault();

            //校验数据
            if (string.IsNullOrEmpty(obj.PayPassword))
            {
                return ResultHelper.Fail("没有支付密码 , 请先设置支付密码");
            }

            obj.CreatorId = obj.CreatorId.GetId();
            obj.PayOption = obj.PayOption.GetId();
            obj.PayState = obj.PayState.GetId();

            //计算实际金额
            obj.Amount = obj.TotalAmount * obj.Discount;

            var cmd = CommandHelper.CreateProcedure(FetchType.Execute, "sp_SaveVipUsePay");
            cmd.Params.Add("@id", obj.Id);
            cmd.Params.Add("@orderNo", null);
            cmd.Params.Add("@amount", obj.Amount, DataType.Decimal);
            cmd.Params.Add("@payPassword", obj.PayPassword);
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
