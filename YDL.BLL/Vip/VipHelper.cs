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
    static class VipHelper
    {
        public static VipBuy GetVipBuy(string id)
        {
            var cmd = CommandHelper.CreateProcedure<VipBuy>(text: "sp_GetVipBuy");
            cmd.Params.Add(CommandHelper.CreateParam("id", id));
            var result = DbContext.GetInstance().Execute(cmd);
            if (result.Entities.IsNotNullOrEmpty())
            {
                return result.FirstEntity<VipBuy>();
            }
            return null;
        }

        public static Response GetVipAccount(string id)
        {
            var cmd = CommandHelper.CreateProcedure<VipAccount>(text: "sp_GetVipAccount");
            cmd.Params.Add(CommandHelper.CreateParam("@userId", id));
            var result = DbContext.GetInstance().Execute(cmd);
            var obj = result.FirstEntity<VipAccount>();
            if (obj != null)
            {
                obj.YueDouBalance = PayHelper.Instance.GetYueDouBalance(id);
            }
            return result;
        }

        /// <summary>
        /// 返回支付单据编号
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
        public static string SaveVipUse(VipUse obj)
        {
            //设置编号
            obj.CityId = obj.CityId.GetId();
            obj.VenueId = obj.VenueId.GetId();
            obj.UserId = obj.UserId.GetId();
            obj.CostTypeId = obj.CostTypeId.GetId();
            obj.CreatorId = obj.CreatorId.GetId();
            obj.PayOption = obj.PayOption.GetId();
            obj.PayState = obj.PayState.GetId();
            obj.OrderNo = SystemHelper.GetSerialNo(SerialNoType.VipUse);
            obj.TrySetNewEntity();

            //插入数据
            var cmd = CommandHelper.CreateProcedure(FetchType.Execute, "sp_SaveVipUse");
            cmd.CreateParamMsg();
            cmd.Params.Add("@Id", obj.Id);
            cmd.Params.Add("@MasterType", obj.MasterType);
            cmd.Params.Add("@MasterId", obj.MasterId);
            cmd.Params.Add("@OrderNo", obj.OrderNo);
            cmd.Params.Add("@CityId", obj.CityId);
            cmd.Params.Add("@VenueId", obj.VenueId);
            cmd.Params.Add("@CostTypeId", obj.CostTypeId);
            cmd.Params.Add("@TotalAmount", obj.TotalAmount, DataType.Double);
            cmd.Params.Add("@Discount", obj.Discount, DataType.Double);
            cmd.Params.Add("@Amount", obj.Amount, DataType.Double);
            cmd.Params.Add("@PayOption", obj.PayOption);
            cmd.Params.Add("@PayId", obj.PayId);
            cmd.Params.Add("@PayState", obj.PayState);
            cmd.Params.Add("@PayDate", obj.PayDate, DataType.DateTime);
            cmd.Params.Add("@PayRemark", obj.PayRemark);
            cmd.Params.Add("@Remark", obj.Remark);
            cmd.Params.Add("@IsOwnCreate", obj.IsOwnCreate, DataType.Boolean);
            cmd.Params.Add("@UserId", obj.UserId);
            cmd.Params.Add("@CreatorId", obj.CreatorId);
            cmd.Params.Add("@CreateDate", obj.CreateDate, DataType.DateTime);
            cmd.Params.Add("@Lng", obj.Lng, DataType.Double);
            cmd.Params.Add("@Lat", obj.Lat, DataType.Double);
            cmd.Params.Add("@Address", obj.Address);

            var result = DbContext.GetInstance().Execute(cmd);
            if (result.IsSuccess && obj.RowState == RowState.Added)
            {
                result.Tag = obj.Id;//返回主键，供下一步使用。
                JPushHelper.SendNotify(MasterType.VIP_USE.Id, obj.Id, "有新的消费单，请及时支付。", new List<string> { obj.CreatorId.GetId() });
            }
            return obj.Id;
        }

        public static Response GetVipRechargeScaleList()
        {
            var cmd = CommandHelper.CreateText<VipRechargeScale>(text: "SELECT * FROM VipRechargeScale ORDER BY Min");
            var result = DbContext.GetInstance().Execute(cmd);
            return result;
        }

        public static Response GetVipUseInfo(string Id, bool IsLiveUpdate)
        {
            var cmd = CommandHelper.CreateProcedure<VipUse>(text: "sp_GetVipUse");
            cmd.Params.Add(CommandHelper.CreateParam("@id", Id));
            cmd.Params.Add(CommandHelper.CreateParam("@isLiveUpdate", IsLiveUpdate));
            return DbContext.GetInstance().Execute(cmd);
        }
    }
}
