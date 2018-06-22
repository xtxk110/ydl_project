
using Newtonsoft.Json;
using YDL.Core;
using YDL.Map;
using YDL.Model;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 获取单个俱乐部信息
    /// </summary>
    public class GetClub : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<Club>>(request);
            var cmd = CommandHelper.CreateProcedure<Club>(text: "sp_GetClub");
            cmd.Params.Add(CommandHelper.CreateParam("@clubId", req.Filter.Id));
            cmd.Params.Add(CommandHelper.CreateParam("@userId", currentUser.Id));
            var result = DbContext.GetInstance().Execute(cmd);

            var club = result.FirstEntity<Club>();
            if (club != null)
            {
                club.TryGetFiles();
                club.ClubAddressList = ClubHelper.GetClubAddressList(club.Id);
                SetClubUserList(club);
            }
            return result;
        }

        private static void SetClubUserList(Club club)
        {
            GetClubUserListFilter filter = new GetClubUserListFilter { ClubId = club.Id, PageIndex = 1, PageSize = 10 };
            var teamListResult = ClubHelper.GetClubUserList(filter);
            if (teamListResult.Entities.IsNotNullOrEmpty())
            {
                club.ClubUserList = teamListResult.Entities.ToList<EntityBase, ClubUser>();
            }
        }
    }

}
