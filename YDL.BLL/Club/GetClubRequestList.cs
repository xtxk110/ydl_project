
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;

namespace YDL.BLL
{
    /// <summary>
    /// 获取俱乐部未处理的加入申请列表
    /// </summary>
    public class GetClubRequestList : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<ClubRequest>>(request);
            var cmd = CommandHelper.CreateProcedure<ClubRequest>(text: "sp_GetClubRequestList");
            cmd.Params.Add(CommandHelper.CreateParam("@clubId", req.Filter.ClubId));
            cmd.Params.Add(CommandHelper.CreateParam("@state", req.Filter.State));
            var result = DbContext.GetInstance().Execute(cmd);

            return result;
        }
    }

}
