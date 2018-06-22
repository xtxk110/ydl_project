using System;
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
    /// 创建比赛
    /// </summary>
    public class SaveGame : IServiceBase
    {
        /// <summary>
        /// 创建比赛
        /// </summary>
        /// <param name="currentUser">忽略</param>
        /// <param name="request">Request.Game</param>
        /// <returns>Response.EmptyEntity</returns>
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<Game>>(request);
            var game = req.FirstEntity();

            SetLinkIdField(game);

            //俱乐部赛事，验证管理员权限
            if (game.ClubId.IsNotNullOrEmpty() && !ClubHelper.IsUserClubAdmin(game.ClubId, currentUser.Id))
            {
                return ResultHelper.Fail("俱乐部管理员才能创建俱乐部比赛。");
            }

            //非小组循环后模式，则设置IsKnockOutAB为false，否则保持用户输入。
            if (game.KnockoutOption != KnockoutOption.ROUND_KNOCKOUT.Id)
            {
                game.IsKnockOutAB = false;
            }

            if (game.RowState == RowState.Added)
            {
                game.SetNewId();
                game.SetCreateDate();
                game.CreatorId = currentUser.Id;
            }
            game.ModifyHeadIcon();

            List<EntityBase> entities = new List<EntityBase> { game };

            //获取将要保存的图片列表
            game.GetWillSaveFileList(entities);

            ////更改相应对阵模板的使用次数,更新多数代码迁移至比赛结束代码接口处,这样统计更准确
            //string oldTempletId = string.Empty;
            //if (game.RowState == RowState.Modified)
            //{
            //    var cmd2 = CommandHelper.CreateText<Game>(FetchType.Fetch, "SELECT TeamMode FROM Game WHERE Id=@gameId");
            //    cmd2.Params.Add("@gameId", game.Id);
            //    var res2 = DbContext.GetInstance().Execute(cmd2);
            //    oldTempletId = (res2.Entities[0] as Game).TeamMode;//旧模板ID
            //}
            //GameLoopTempletHelper.UpdateTempletUseCount(game.TeamMode, oldTempletId);
            /////////////////////////

            var result = DbContext.GetInstance().Execute(CommandHelper.CreateSave(entities));
            

            if (game.ClubId.IsNotNullOrEmpty() && game.RowState == RowState.Added)
            {
                try
                {
                    NotifyClubUser(game);
                }
                catch (Exception)
                {
                }
            }
            return result;
        }

        private static void SetLinkIdField(Game game)
        {
            game.BattleStyle = game.BattleStyle.GetId();
            game.NameOption = game.NameOption.GetId();

            var style = TTBattleStyle.find(game.BattleStyle);
            game.IsTeam = (bool)style.Tag2;
            game.BattleStyleCount = (int)style.Tag;

            //处理LinkId值
            game.KnockoutOption = game.KnockoutOption.GetId();
            game.CreatorId = game.CreatorId.GetId();
            game.ClubId = game.ClubId.GetId();
            game.CityId = game.CityId.GetId();
            game.VenueId = game.VenueId.GetId();
            game.TeamMode = game.TeamMode.GetId();
        }

        private static void NotifyClubUser(Game game)
        {
            var clubUses = ClubHelper.GetClubUserIdList(game.ClubId);
            if (clubUses.IsNotNullOrEmpty())
            {
                var club = ClubHelper.GetClub(game.ClubId);
                string msg = string.Format("{0}创建了比赛[{1}]，比赛时间[{2}]，请积极报名参加。", club.Name, game.Name, game.PlayBeginTime.ToString(Constant.DateTimeFormatCN));
                JPushHelper.SendNotify(MasterType.GAME.Id, game.Id, msg, clubUses);
            }
        }
    }
}
