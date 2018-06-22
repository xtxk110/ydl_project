
using Newtonsoft.Json;
using YDL.Map;
using YDL.Utility;
using YDL.Model;

namespace YDL.BLL
{
    /// <summary>
    /// 获取用户积分变动记录(done)
    /// </summary>
    public class GetUserScoreHistoryList : IServiceBase
    {
        /// <summary>
        /// 获取用户积分变动记录
        /// </summary>
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetUserScoreHistoryListFilter>>(request);
            var cmd = CommandHelper.CreateProcedure<UserScoreHistory>(text: "sp_GetUserScoreHistoryList");
            cmd.Params.Add(CommandHelper.CreateParam("@userId", req.Filter.UserId));
            cmd.Params.Add(CommandHelper.CreateParam("@sportId", req.Filter.SportId));
            cmd.CreateParamPager(req.Filter);
            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();

            return result;
        }
    }

}
