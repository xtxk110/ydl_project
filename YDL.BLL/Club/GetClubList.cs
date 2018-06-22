using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Core;

namespace YDL.BLL
{
    /// <summary>
    /// 获取俱乐部列表，带分页功能
    /// </summary>
    public class GetClubList : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetClubListFilter>>(request);
            var cmd = CommandHelper.CreateProcedure<Club>(text: "sp_GetClubList");
            cmd.Params.Add(CommandHelper.CreateParam("@sportTypeId", req.Filter.SportTypeId));
            cmd.Params.Add(CommandHelper.CreateParam("@cityId", req.Filter.CityId));
            cmd.Params.Add(CommandHelper.CreateParam("@userId", currentUser.Id));
            cmd.Params.Add(CommandHelper.CreateParam("@name", req.Filter.Name));
            cmd.Params.Add(CommandHelper.CreateParam("@pageIndex", req.Filter.PageIndex));
            cmd.Params.Add(CommandHelper.CreateParam("@pageSize", req.Filter.PageSize));
            cmd.Params.Add(CommandHelper.CreateParam("@rowCount", 0, DataType.Int32, ParamDirection.Output));
            var result = DbContext.GetInstance().Execute(cmd);
            result.RowCount = (int)result.OutParams.FirstOrDefault().value;

            return result;
        }
    }    
}
