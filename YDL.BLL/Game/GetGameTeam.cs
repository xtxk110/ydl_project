using System;
using System.Collections.Generic;
using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Core;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 获取比赛报名队伍
    /// </summary>
    public class GetGameTeam : IService
    {
        /// <summary>
        /// 获取比赛报名队伍
        /// </summary>
        /// <param name="request">Request.GameTeam.Filter</param>
        /// <returns>Response.GameTeam</returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<BaseData>>(request);
            var cmd = CommandHelper.CreateProcedure<GameTeam>(text: "sp_GetGameTeam");
            cmd.Params.Add(CommandHelper.CreateParam("@TeamId", req.Filter.Id));

            var result = DbContext.GetInstance().Execute(cmd);
            if (result.Entities != null && result.Entities.Count > 0)
            {
                GameTeam gt = result.Entities[0] as GameTeam;
                gt.TeamDetail = GetTeamDetail(gt.TeamUserId);
            }

            return result;
        }
        /// <summary>
        /// 通过队伍内用户ID获取用户详情
        /// </summary>
        /// <param name="teamUserId"></param>
        /// <returns></returns>
        private List<TeamDetail> GetTeamDetail(string teamUserId)
        {
            List<TeamDetail> list = new List<TeamDetail>();
            string sqlStr = @"SELECT a.HeadUrl,a.CardName,a.PetName,a.Sex,b.Score AS 'SportScore' FROM UserAccount AS a LEFT JOIN UserSport AS b ON a.Id=b.UserId WHERE CHARINDEX(a.Id, @teamUserId)>0";
            var cmd = CommandHelper.CreateText<TeamDetail>(FetchType.Fetch,sqlStr);
            cmd.Params.Add(CommandHelper.CreateParam("@teamUserId", teamUserId));
            var result = DbContext.GetInstance().Execute(cmd);
            if (result.Entities != null)
            {
                list= result.Entities.ToList<EntityBase, TeamDetail>();
            }
            return list;
        }
    }
}
