using System;
using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Core;

namespace YDL.BLL
{
    /// <summary>
    /// 获取需要我打分的比赛对阵列表（未结束的对阵）
    /// </summary>
    public class GetGameJudgeLoopListOfMine : IServiceBase
    {
        /// <summary>
        /// 获取需要我打分的比赛对阵列表（未结束的对阵）
        /// </summary>
        /// <param name="currentUser">忽略</param>
        /// <param name="request">Request.Game.Filter</param>
        /// <returns>Response.GameLoop</returns>
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetGameJudgeLoopListFilter>>(request);
            var sql = @"SELECT a.* FROM GameLoop a INNER JOIN GameOrder b ON b.Id=a.OrderId
                            WHERE a.JudgeId = @judgeId
                            AND ( b.KnockoutOption = '014002' --小组赛不为空
                                AND a.IsBye = 0
                                OR b.KnockoutOption = '014001'--淘汰赛
                            ) 
                            AND a.State!='011003';--对阵未结束";
            var cmd = CommandHelper.CreateText<GameLoop>(FetchType.Fetch, sql);
            cmd.Params.Add(CommandHelper.CreateParam("@judgeId", currentUser.Id));
            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();

            return result;
        }

    }
}
