using System.Text;
using System.Collections.Generic;

using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Utility;
using YDL.Core;

namespace YDL.BLL
{
    /// <summary>
    /// 获取场地列表(已审核的) 图形界面用
    /// </summary>
    public class GetVenueListForGraph : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetVenueListFilter>>(request);

            var cmd = CommandHelper.CreateProcedure<Venue>(text: "sp_GetVenueListForGraph");
            cmd.Params.Add(CommandHelper.CreateParam("@Name", req.Filter.Name));
            cmd.Params.Add(CommandHelper.CreateParam("@CityCode", req.Filter.CityId));
            cmd.Params.Add(CommandHelper.CreateParam("@isUseVip", req.Filter.IsUseVip));
            cmd.Params.Add(CommandHelper.CreateParam("@isOnlySelf", req.Filter.IsOnlySelf));

            cmd.Params.Add(CommandHelper.CreateParam("@curUserLng", req.Filter.CurUserLng, DataType.Double));
            cmd.Params.Add(CommandHelper.CreateParam("@curUserLat", req.Filter.CurUserLat, DataType.Double));

            cmd.Params.Add(CommandHelper.CreateParam("@creatorId", currentUser.Id));
            if (req.Filter.Distance != 0)
            {
                req.Filter.Distance = req.Filter.Distance / 1000; //换算成千米
            }
            cmd.Params.Add(CommandHelper.CreateParam("@Distance", req.Filter.Distance));


            cmd.CreateParamUser(req.Filter.UserId.GetId());
            cmd.CreateParamPager(req.Filter);

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();

            return result;
        }
    }

    /// <summary>
    /// 获取地图模式(游客)
    /// </summary>
    public class GetVenueListForGraph2 : IService
    {
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetVenueListFilter>>(request);

            var cmd = CommandHelper.CreateProcedure<Venue>(text: "sp_GetVenueListForGraph");
            cmd.Params.Add(CommandHelper.CreateParam("@Name", req.Filter.Name));
            cmd.Params.Add(CommandHelper.CreateParam("@CityCode", req.Filter.CityId));
            cmd.Params.Add(CommandHelper.CreateParam("@isUseVip", req.Filter.IsUseVip));
            cmd.Params.Add(CommandHelper.CreateParam("@isOnlySelf", req.Filter.IsOnlySelf));

            cmd.Params.Add(CommandHelper.CreateParam("@curUserLng", req.Filter.CurUserLng, DataType.Double));
            cmd.Params.Add(CommandHelper.CreateParam("@curUserLat", req.Filter.CurUserLat, DataType.Double));

            cmd.Params.Add(CommandHelper.CreateParam("@creatorId", "tourist"));
            if (req.Filter.Distance != 0)
            {
                req.Filter.Distance = req.Filter.Distance / 1000; //换算成千米
            }
            cmd.Params.Add(CommandHelper.CreateParam("@Distance", req.Filter.Distance));


            cmd.CreateParamUser(req.Filter.UserId.GetId());
            cmd.CreateParamPager(req.Filter);

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();

            return result;
        }
    }
}
