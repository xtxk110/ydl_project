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
    /// 保存悦豆消费
    /// </summary>
    public class SaveYueDouUse_188 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<VipPayInfo>>(request);
            var obj = req.FirstEntity();
            Response rsp = ResultHelper.CreateResponse();
            //判断余额是否够
            if (!GuessHelper.Instance.IsBalanceSufficient(obj.CurrentUserId, obj.YueDouAmount))
            {
                return ResultHelper.Fail("没有足够的悦豆余额, 请充值");
            }

            //扣除悦豆
            rsp = GuessHelper.Instance.AddOrSubYueDou(-obj.YueDouAmount, obj.CurrentUserId);
            //插入悦豆账单
            if (rsp.IsSuccess)
            {
                var yueDouFlow = new YueDouFlow();
                yueDouFlow.Amount = -obj.YueDouAmount;
                yueDouFlow.UserId = obj.CurrentUserId;
                yueDouFlow.FlowType = GuessDic.VenueCost;
                rsp = GuessHelper.Instance.AddYueDouFlow(yueDouFlow);
            }

            //增加场馆创建者的悦豆数
            Venue venue = VenueHelper.Instance.GetVenueById(obj.VenueId);
            if (rsp.IsSuccess)
            {
                rsp = GuessHelper.Instance.AddOrSubYueDou(obj.YueDouAmount, venue.CreatorId);
                //插入悦豆账单
                var yueDouFlow = new YueDouFlow();
                yueDouFlow.Amount = obj.YueDouAmount;
                yueDouFlow.UserId = venue.CreatorId;
                yueDouFlow.FlowType = GuessDic.VenueEarn;
                rsp = GuessHelper.Instance.AddYueDouFlow(yueDouFlow);
            }

            //返回成功支付的信息
            VipUse vipUse = new VipUse();
            vipUse.OrderNo = SystemHelper.GetSerialNo(SerialNoType.VipUse);
            vipUse.Amount = obj.YueDouAmount;
            vipUse.Remark = "";
            vipUse.PayDate = DateTime.Now;
            vipUse.MasterName = venue.Name;
            rsp.Entities.Add(vipUse);
            return rsp;

        }


    }
}
