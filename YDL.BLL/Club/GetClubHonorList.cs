
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;

namespace YDL.BLL
{
    /// <summary>
    /// 获取俱乐部等级定义列表
    /// </summary>
    public class GetClubHonorList : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<ClubHonor>>(request);
            var cmd = CommandHelper.CreateText<ClubHonor>(text: "SELECT * FROM ClubHonor WHERE ClubId=@ClubId ORDER BY SortIndex");
            cmd.Params.Add(CommandHelper.CreateParam("@ClubId", req.Filter.ClubId));

            return DbContext.GetInstance().Execute(cmd);
        }
    }

}
