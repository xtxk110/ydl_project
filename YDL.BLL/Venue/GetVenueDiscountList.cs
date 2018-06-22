using System.Text;
using System.Collections.Generic;
using System;

using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Utility;
using YDL.Core;

namespace YDL.BLL
{
    /// <summary>
    /// 场馆折扣管理列表
    /// </summary>
    public class GetVenueDiscountList : IService
    {
        /// <summary>
        /// 场馆折扣管理列表
        /// </summary>
        /// <param name="request">Filter：VenueDiscount</param>
        /// <returns>VenueDiscount</returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<VenueDiscount>>(request);

            var cmd = CommandHelper.CreateProcedure<VenueDiscount>(text: "sp_GetVenueDiscountList");
            cmd.Params.Add(CommandHelper.CreateParam("@venueId", req.Filter.VenueId.GetId()));
            cmd.Params.Add(CommandHelper.CreateParam("@today", req.Filter.Today.ToDbString()));
            cmd.Params.Add(CommandHelper.CreateParam("@costTypeId", req.Filter.CostTypeId.GetId()));

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();

            return result;
        }
    }



}
