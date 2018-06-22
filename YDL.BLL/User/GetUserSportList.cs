
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;

namespace YDL.BLL
{
    /// <summary>
    /// 获取用户运动爱好列表(done)
    /// </summary>
    public class GetUserSportList : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<UserSport>>(request);
            var cmd = CommandHelper.CreateProcedure<UserSport>(text: "sp_GetUserSportList");
            cmd.Params.Add(CommandHelper.CreateParam("@userId", req.Filter.UserId));
            cmd.Params.Add(CommandHelper.CreateParam("@sportId", req.Filter.SportId));

            return DbContext.GetInstance().Execute(cmd);
        }
    }

}
