using System;
using System.Text;
using System.Linq;
using System.Collections.Generic;

using Newtonsoft.Json;
using YDL.Core;
using YDL.Map;
using YDL.Model;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 参赛队伍报名
    /// </summary>
    public class SaveGameTeam : IServiceBase
    {
        /// <summary>
        /// 参赛队伍报名
        /// </summary>
        /// <param name="currentUser">忽略</param>
        /// <param name="request">Request.GameTeam</param>
        /// <returns>Response.EmptyEntity</returns>
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GameTeam>>(request);
            var team = req.Entities.FirstOrDefault();
            //////////////////团体对阵时增加对阵模板上场人数与队员人数比较/////////////////////
            if (team.IsTeam)
            {
                bool flag = GameLoopTempletHelper.IsJoinGame(team.GameId, team.TeamUserId);
                if (!flag)
                    return ResultHelper.Fail("参赛队伍人数少于团体对阵模板最少人数");
            }

            ////////////////////////////////////////////////////////////////////
            team.AuditorId = team.AuditorId.GetId();
            team.CreatorId = team.CreatorId.GetId();
            team.GameId = team.GameId.GetId();
            team.State = team.State.GetId();
            team.CompanyId = team.CompanyId.GetId();
            if (team.TeamName.IsNullOrEmpty())
            {
                team.TeamName = team.TeamUserName;
            }
            if (string.IsNullOrEmpty(team.NationalId))
            {
                team.NationalId = "flag_china@2x";//默认是中国
            }
            var entities = new List<EntityBase> { team };
            if (team.RowState == RowState.Added)
            {
                team.SetNewId();
                team.SetCreateDate();
                if (team.CreatorId.IsNullOrEmpty())
                {
                    team.CreatorId = currentUser.Id;
                }
                //如果没有设置头像，则使用当前创建者的头像
                SetHeadUrl(team.CreatorId, team);
            }

            var resultCheck = Validate(team, team.CreatorId.GetId());//待加入存在未支付消费的验证
            if (!resultCheck.IsSuccess)
            {
                return ResultHelper.Fail(resultCheck.Message);
            }

            team.ModifyHeadIcon();
            var result = DbContext.GetInstance().Execute(CommandHelper.CreateSave(entities));
            try
            {
                var game = GameHelper.GetGame(team.GameId);
                var msg = string.Format("有参赛人员[{0}]报名，请及时审核资格。", team.TeamName);
                JPushHelper.SendNotify(MasterType.GAME.Id, game.Id, msg, new List<string> { game.CreatorId });
            }
            catch (Exception)
            {
            }
            return result;
        }

        private static void SetHeadUrl(string userId, GameTeam team)
        {
            if (team.HeadUrl.IsNullOrEmpty())
            {
                var cmd = CommandHelper.CreateText<User>(text: "SELECT HeadUrl FROM UserAccount WHERE Id=@userId");
                cmd.CreateParamUser(userId);
                var temp = DbContext.GetInstance().Execute(cmd).Entities.First() as User;
                team.HeadUrl = temp.HeadUrl;
                team.HeadUrlOld = temp.HeadUrl;
            }
        }

        private static Response Validate(GameTeam team, string currentUserId)
        {
            var cmd = CommandHelper.CreateProcedure(FetchType.Execute, "sp_ValidateGameTeam");
            cmd.Params.Add(CommandHelper.CreateParam("@GameId", team.GameId));
            cmd.Params.Add(CommandHelper.CreateParam("@TeamId", team.Id));
            cmd.Params.Add(CommandHelper.CreateParam("@UserList", team.TeamUserId));
            cmd.CreateParamMsg();
            cmd.CreateParamUser(currentUserId);

            return DbContext.GetInstance().Execute(cmd);
        }
    }
}
