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
    /// 获取用户签到列表
    /// </summary>
    public class GetUserSignList : IService
    {
        /// <summary>
        /// 获取用户签到列表
        /// </summary>
        /// <param name="request">Filter：VenueSign</param>
        /// <returns>VenueSign</returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetUserSignListFilter>>(request);

            var cmd = CommandHelper.CreateProcedure<UserSign>(text: "sp_GetUserSignList");
            cmd.Params.Add(CommandHelper.CreateParam("@masterType", req.Filter.MasterType.GetId()));
            cmd.Params.Add(CommandHelper.CreateParam("@masterId", req.Filter.MasterId.GetId()));
            cmd.Params.Add(CommandHelper.CreateParam("@userId", req.Filter.UserId.GetId()));
            cmd.Params.Add(CommandHelper.CreateParam("@signDate", req.Filter.SignDate));
            cmd.CreateParamPager(req.Filter);

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();

            return result;
        }
    }



}
