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
    /// 保存场馆折扣管理
    /// </summary>
    public class SaveVenueDiscount : IService
    {
        /// <summary>
        /// 保存场馆折扣管理
        /// </summary>
        /// <param name="request">实体VenueDiscount</param>
        /// <returns></returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<VenueDiscount>>(request);
            var obj = req.FirstEntity();

            obj.CreatorId = obj.CreatorId.GetId();
            obj.CostTypeId = obj.CostTypeId.GetId();
            obj.VenueId = obj.VenueId.GetId();
            if (obj.RowState != RowState.Deleted && (obj.CreatorId.IsNullOrEmpty() || obj.VenueId.IsNullOrEmpty() || obj.CostTypeId.IsNullOrEmpty()))
            {
                return ResultHelper.Fail("请输入场馆，费用类型和创建人。");
            }

            var cmd = CommandHelper.CreateProcedure(FetchType.Execute, "sp_SaveVenueDiscount");
            cmd.Params.Add("@Id", obj.Id);
            cmd.Params.Add("@VenueId", obj.VenueId);
            cmd.Params.Add("@CostTypeId", obj.CostTypeId);
            cmd.Params.Add("@Discount", obj.Discount, DataType.Decimal);
            cmd.Params.Add("@BeginDate", obj.BeginDate, DataType.DateTime);
            cmd.Params.Add("@EndDate", obj.EndDate, DataType.DateTime);
            cmd.Params.Add("@CreatorId", obj.CreatorId);
            cmd.CreateParamActionCode(obj.RowState);
            cmd.CreateParamMsg();

            return DbContext.GetInstance().Execute(cmd);
        }

    }

}
