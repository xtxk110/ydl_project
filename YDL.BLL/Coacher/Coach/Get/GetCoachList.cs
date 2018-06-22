using System;
using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Core;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 获取教练列表
    /// </summary>
    public class GetCoachList : IService
    {
        public Response Execute(string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetCoachRelatedFilter>>(request);
            //默认参数
            req.Filter.OrderType = "DESC";
            req.Filter.OrderColumn = "CoachAge";
            //查询
            var cmd = CommandHelper.CreateProcedure<Coach>(text: "sp_GetCoachList");
            cmd.Params.Add(CommandHelper.CreateParam("@orderColumn", req.Filter.OrderColumn));
            cmd.Params.Add(CommandHelper.CreateParam("@orderType", req.Filter.OrderType));
            if (string.IsNullOrEmpty(req.Filter.CityId))
            {
                req.Filter.CityId = "75";
            }
            cmd.Params.Add(CommandHelper.CreateParam("@cityId", req.Filter.CityId));
            cmd.Params.Add(CommandHelper.CreateParam("@coacherName", req.Filter.Name));
            cmd.Params.Add(CommandHelper.CreateParam("@curUserLng", req.Filter.CurUserLng, DataType.Double));
            cmd.Params.Add(CommandHelper.CreateParam("@curUserLat", req.Filter.CurUserLat, DataType.Double));
            var distance = Helper.ConvertMToKM(req.Filter.Distance);
 
            cmd.Params.Add(CommandHelper.CreateParam("@distance", distance));


            cmd.CreateParamPager(req.Filter);

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();

            return result;


        }


    }
}
