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
    /// 获取场馆列表(未审核)--管理员审核场地界面用, 这里只出未审核的场地
    /// </summary>
    public class GetVenueListForAudit : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetVenueListFilter>>(request);

            var cmd = CommandHelper.CreateProcedure<Venue>(text: "sp_GetVenueListForAudit");
            cmd.Params.Add(CommandHelper.CreateParam("@Name", req.Filter.Name));
            cmd.Params.Add(CommandHelper.CreateParam("@CityCode", req.Filter.CityId));
            cmd.Params.Add(CommandHelper.CreateParam("@isUseVip", req.Filter.IsUseVip));
            cmd.Params.Add(CommandHelper.CreateParam("@isOnlySelf", req.Filter.IsOnlySelf));

            cmd.Params.Add(CommandHelper.CreateParam("@curUserLng", req.Filter.CurUserLng, DataType.Double));
            cmd.Params.Add(CommandHelper.CreateParam("@curUserLat", req.Filter.CurUserLat, DataType.Double));

            cmd.Params.Add(CommandHelper.CreateParam("@isAll", false));
            cmd.Params.Add(CommandHelper.CreateParam("@state", req.Filter.State));


            cmd.CreateParamUser(req.Filter.UserId.GetId());
            cmd.CreateParamPager(req.Filter);

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();

            return result;
        }
    }



}
