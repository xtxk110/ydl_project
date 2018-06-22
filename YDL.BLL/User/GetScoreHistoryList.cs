using Newtonsoft.Json;
using YDL.Map;
using YDL.Utility;
using YDL.Model;

namespace YDL.BLL
{
    /// <summary>
    /// 获取某个用户的积分历史
    /// </summary>
    class GetScoreHistoryList : IServiceBase
    {
        /// <summary>
        /// 获取用户积分变动记录
        /// </summary>
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetUserScoreHistoryListFilter>>(request);
            var cmd = CommandHelper.CreateProcedure<ScoreHistory>(text: "sp_GetScoreHistoryList");
            cmd.Params.Add(CommandHelper.CreateParam("@userId", req.Filter.UserId));
            cmd.Params.Add(CommandHelper.CreateParam("@sportId", req.Filter.SportId));
            cmd.CreateParamPager(req.Filter);
            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();
            foreach (var item in result.Entities)
            {
                ScoreHistory sh = item as ScoreHistory;
                if (sh.Editor=="0")//默认积分,查询时Editor字段写死
                {
                    sh.Description = "您获得了初始积分";
                    sh.ScoreStr = sh.Score.ToString();
                }
                else if (!string.IsNullOrEmpty(sh.LoopId))
                {
                    string des = "您在{0}中的一场比赛{1}了{2},积分{3}了";
                    if (sh.Score >= 0)
                    {
                        sh.Description = string.Format(des, sh.GameName, "获得", "胜利", "增加");
                        sh.ScoreStr = "+" + sh.Score.ToString();
                    }
                    else
                    {
                        sh.Description = string.Format(des, sh.GameName, "遭遇", "失败", "减少");
                        sh.ScoreStr = sh.Score.ToString();
                    }

                }
                else if (sh.IsEdit)
                {
                    sh.Description = "管理员根据您的水平,调整了积分";
                    if (sh.Score - sh.OldScore >= 0)
                        sh.ScoreStr = "+" + (sh.Score - sh.OldScore).ToString();
                    else
                        sh.ScoreStr = (sh.Score - sh.OldScore).ToString();
                }
                else
                {
                    sh.Description = "管理员根据您的水平,调整了您的最终积分值";
                    sh.ScoreStr = sh.Score.ToString();
                }

            }

            return result;
        }
    }
}