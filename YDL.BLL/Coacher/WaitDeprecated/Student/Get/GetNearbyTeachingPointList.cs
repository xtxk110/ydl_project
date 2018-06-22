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
    /// 获取附近教学点列表
    /// </summary>
    public class GetNearbyTeachingPointList : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetVenueListFilter>>(request);

            var cmd = CommandHelper.CreateProcedure<Venue>(text: "sp_GetNearbyTeachingPointList");
            cmd.Params.Add(CommandHelper.CreateParam("@Name", req.Filter.Name));
            if (string.IsNullOrEmpty(req.Filter.CityId))
            {
                req.Filter.CityId = "75";
            }
            cmd.Params.Add(CommandHelper.CreateParam("@CityCode", req.Filter.CityId));
            cmd.Params.Add(CommandHelper.CreateParam("@curUserLng", req.Filter.CurUserLng, DataType.Double));
            cmd.Params.Add(CommandHelper.CreateParam("@curUserLat", req.Filter.CurUserLat, DataType.Double));
            cmd.CreateParamUser(req.Filter.UserId.GetId()); //传当前用户Id

            //不用传的参数
            cmd.Params.Add(CommandHelper.CreateParam("@isUseVip", ""));
            cmd.Params.Add(CommandHelper.CreateParam("@isOnlySelf", false));
            cmd.Params.Add(CommandHelper.CreateParam("@isAll", false));
            cmd.Params.Add(CommandHelper.CreateParam("@state", ""));
        
            cmd.CreateParamPager(req.Filter);

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();

            return result;

        }

    }
}
