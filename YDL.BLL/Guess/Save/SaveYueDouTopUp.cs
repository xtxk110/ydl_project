using System;
using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Core;
using YDL.Utility;
using System.Collections.Generic;

namespace YDL.BLL
{
    /// <summary>
    /// 保存悦豆充值
    /// </summary>
    public class SaveYueDouTopUp_188 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<VipUse>>(request);
            var vipUse = req.FirstEntity();
            if (string.IsNullOrEmpty(vipUse.CityId))
            {
                vipUse.CityId = "75";
            }

            Response rsp = ResultHelper.CreateResponse();
            //生成 待支付订单
            vipUse.Id = Ext.NewId();
            vipUse.MasterType = MasterType.YUEDOUPAY.Id;
            vipUse.MasterId = "";
            vipUse.VenueId = "";
            vipUse.CostTypeId = CostType.YUEDOUCOST.Id;
            vipUse.Discount = 1;
            vipUse.Amount = vipUse.TotalAmount * vipUse.Discount;
            vipUse.PayState = PayState.PAY.Id;//待支付
            vipUse.IsOwnCreate = true;
            vipUse.CreatorId = currentUser.Id;
            vipUse.CreateDate = DateTime.Now;
            rsp.Tag = VipHelper.SaveVipUse(vipUse);
            rsp.IsSuccess = true;
            return rsp;
        }



    }
}
