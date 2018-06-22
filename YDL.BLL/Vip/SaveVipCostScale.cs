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
    /// 保存结算分配比例(done)
    /// </summary>
    public class SaveVipCostScale : IServiceBase
    {
        /// <summary>
        /// 保存结算分配比例
        /// </summary>
        /// <param name="request">实体VipCostScale</param>
        /// <returns></returns>
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<VipCostScale>>(request);
            var obj = req.FirstEntity();

            if (obj.RowState != RowState.Deleted && (obj.CreatorId.IsNullOrEmpty() || obj.CompanyId.IsNullOrEmpty() || obj.CostTypeId.IsNullOrEmpty()))
            {
                return ResultHelper.Fail("请输入机构，费用类型和创建人。");
            }

            var cmd = CommandHelper.CreateProcedure(FetchType.Execute, "sp_SaveVipCostScale");
            cmd.Params.Add("@Id", obj.Id);
            cmd.Params.Add("@CompanyId", obj.CompanyId.GetId());
            cmd.Params.Add("@CostTypeId", obj.CostTypeId.GetId());
            cmd.Params.Add("@CityId", obj.CityId.GetId());
            cmd.Params.Add("@YdlScale", obj.YdlScale, DataType.Decimal);
            cmd.Params.Add("@CompanyScale", obj.CompanyScale, DataType.Decimal);
            cmd.Params.Add("@VenueScale", obj.VenueScale, DataType.Decimal);
            cmd.Params.Add("@CreatorId", obj.CreatorId.GetId());
            cmd.Params.Add("@Remark", obj.Remark);
            cmd.CreateParamActionCode(obj.RowState);
            cmd.CreateParamMsg();

            return DbContext.GetInstance().Execute(cmd);
        }

    }

}
