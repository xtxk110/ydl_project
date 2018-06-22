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
    /// 比赛工具类
    /// </summary>
    static class GameHelper
    {
        public static void SetGameTeamList(Game game)
        {
            GetGameTeamListFilter filter = new GetGameTeamListFilter { GameId = game.Id, PageIndex = 1, PageSize = 10 };
            var teamListResult = GameHelper.GetGameTeamList(filter);
            if (teamListResult.Entities.IsNotNullOrEmpty())
            {
                game.GameTeamList = teamListResult.Entities.ToList<EntityBase, GameTeam>();
            }
        }

        public static Response GetGameLoopDetailList(GetGameLoopDetailListFilter filter)
        {
            var cmd = CommandHelper.CreateProcedure<GameLoopDetail>(text: "sp_GetGameLoopDetailList");
            cmd.Params.Add(CommandHelper.CreateParam("@MapId", filter.MapId));
            cmd.Params.Add(CommandHelper.CreateParam("@LoopId", filter.LoopId));
            var res= DbContext.GetInstance().Execute(cmd);
            
            return res;
        }

        public static Response GetGameTeamList(GetGameTeamListFilter filter)
        {
            var cmd = CommandHelper.CreateProcedure<GameTeam>(text: "sp_GetGameTeamList");
            cmd.Params.Add(CommandHelper.CreateParam("@GameId", filter.GameId));
            cmd.Params.Add(CommandHelper.CreateParam("@teamName", filter.TeamName));
            cmd.Params.Add(CommandHelper.CreateParam("@state", filter.State));
            cmd.Params.Add(CommandHelper.CreateParam("@onlyNotGroup", filter.OnlyNotGroup));
            cmd.CreateParamPager(filter);

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();

            return result;
        }

        public static Command GetDeleteLoopDetailCmd(string loopId, string mapId)
        {
            var cmd = CommandHelper.CreateText(FetchType.Execute);
            cmd.Text = " DELETE FROM GameLoopDetail WHERE LoopId=@loopId ";
            cmd.Params.Add("@loopId", loopId);
            if (mapId.IsNotNullOrEmpty())
            {
                cmd.Text += " AND MapId=@mapId";
                cmd.Params.Add("@mapId", mapId);
            }

            return cmd;
        }

        public static List<GameLoop> GetOrderLoopListNoExtra(string orderId)
        {
            var cmdLoop = CommandHelper.CreateText<GameLoop>(text: "SELECT * FROM dbo.GameLoop WHERE OrderId=@OrderId AND IsExtra=0 ORDER BY OrderNo");
            cmdLoop.Params.Add(CommandHelper.CreateParam("@OrderId", orderId));
            var secondLoopList = DbContext.GetInstance().Execute(cmdLoop).Entities.ToList<EntityBase, GameLoop>();
            return secondLoopList;
        }

        /// <summary>
        /// 获取并设置比赛小组成员
        /// </summary>
        /// <param name="group"></param>
        public static void SetGroupMemberList(GameGroup group)
        {
            var cmd = CommandHelper.CreateProcedure<GameGroupMember>(text: "sp_GetGameGroupMemberList");
            cmd.Params.Add(CommandHelper.CreateParam("@gameId", group.GameId));
            cmd.Params.Add(CommandHelper.CreateParam("@groupId", group.Id));
            var result = DbContext.GetInstance().Execute(cmd);
            group.MemberList = new List<GameGroupMember>();
            foreach (var user in result.Entities)
            {
                group.MemberList.Add(user as GameGroupMember);
            }
        }

        /// <summary>
        /// 获取某场团队比赛对阵列表
        /// </summary>
        /// <param name="loopId"></param>
        /// <returns></returns>
        public static List<GameGroup> GetOrderGroupList(string orderId)
        {
            var cmd = CommandHelper.CreateText<GameGroup>(text: "SELECT * FROM GameGroup WHERE OrderId=@orderId ORDER BY OrderNo");
            cmd.Params.Add(CommandHelper.CreateParam("@orderId", orderId));
            var items = DbContext.GetInstance().Execute(cmd).Entities.ToList<EntityBase, GameGroup>();
            return items;
        }

        /// <summary>
        /// 获取某小组比赛列表，排除轮空场次
        /// </summary>
        /// <param name="loopId"></param>
        /// <returns></returns>
        public static List<GameLoop> GetGroupLoopList(string groupId)
        {
            var cmd = CommandHelper.CreateText<GameLoop>(text: "SELECT * FROM GameLoop WHERE GroupId=@groupId AND IsBye=0 ORDER BY OrderNo");
            cmd.Params.Add(CommandHelper.CreateParam("@groupId", groupId));
            var items = DbContext.GetInstance().Execute(cmd).Entities.ToList<EntityBase, GameLoop>();
            return items;
        }

        /// <summary>
        /// 获取某场团队比赛对阵列表
        /// </summary>
        /// <param name="loopId"></param>
        /// <returns></returns>
        public static List<GameLoopMap> GetLoopMapList(string loopId)
        {
            var cmd = CommandHelper.CreateText<GameLoopMap>(text: "SELECT * FROM GameLoopMap WHERE LoopId=@LoopId");
            cmd.Params.Add(CommandHelper.CreateParam("@LoopId", loopId));
            var items = DbContext.GetInstance().Execute(cmd).Entities.ToList<EntityBase, GameLoopMap>();
            return items;
        }

        /// <summary>
        /// 获取所有存在相同单位队伍的参赛者
        /// </summary>
        /// <param name="gameId"></param>
        /// <returns></returns>
        public static List<GameTeam> GetSameCorpTeamList(string gameId)
        {
            var cmd = CommandHelper.CreateText<GameTeam>(text: "SELECT Id,CompanyId FROM GameTeam WHERE GameId=@gameId AND State=@state AND ISNULL(CompanyId,'')!=''");
            cmd.Params.Add(CommandHelper.CreateParam("@gameId", gameId));
            cmd.Params.Add(CommandHelper.CreateParam("@state", GameTeamState.PASS.Id));
            var items = DbContext.GetInstance().Execute(cmd).Entities.ToList<EntityBase, GameTeam>();

            return items;
        }

        /// <summary>
        /// 获取所有通过审核的比赛人员
        /// </summary>
        /// <param name="loopId"></param>
        /// <returns></returns>
        public static List<string> GetAllUserIdList(string gameId)
        {
            var cmd = CommandHelper.CreateText<GameTeam>(text: "SELECT TeamUserId,CreatorId FROM GameTeam WHERE GameId=@gameId AND State=@state");
            cmd.Params.Add(CommandHelper.CreateParam("@gameId", gameId));
            cmd.Params.Add(CommandHelper.CreateParam("@state", GameTeamState.PASS.Id));
            var items = DbContext.GetInstance().Execute(cmd).Entities.ToList<EntityBase, GameTeam>();

            List<string> result = new List<string>();
            foreach (var team in items)
            {
                result.Add(team.CreatorId);
                if (team.TeamUserId.IsNotNullOrEmpty())
                {
                    var arr = team.TeamUserId.Split(Constant.Chr_Comma);
                    result.AddRange(arr);
                }
            }
            return result;
        }

        /// <summary>
        /// 获取某场比赛
        /// </summary>
        /// <param name="loopId"></param>
        /// <returns></returns>
        public static GameLoop GetLoop(string loopId)
        {
            var cmd = CommandHelper.CreateText<GameLoop>(text: "SELECT * FROM GameLoop WHERE Id=@LoopId");
            cmd.Params.Add(CommandHelper.CreateParam("@LoopId", loopId));
            var result = DbContext.GetInstance().Execute(cmd);
            return result.Entities.First() as GameLoop;
        }

        /// <summary>
        /// 获取某比赛
        /// </summary>
        /// <param name="token"></param>
        /// <param name="gameId"></param>
        /// <returns></returns>
        public static Game GetGame(string userId, string gameId)
        {
            var cmd = CommandHelper.CreateProcedure<Game>(text: "sp_GetGame");
            cmd.Params.Add(CommandHelper.CreateParam("@userId", userId));
            cmd.Params.Add(CommandHelper.CreateParam("@gameId", gameId));

            return DbContext.GetInstance().Execute(cmd).FirstEntity<Game>();
        }

        /// <summary>
        /// 获取某比赛
        /// </summary>
        /// <param name="token"></param>
        /// <param name="gameId"></param>
        /// <returns></returns>
        public static Game GetGame(string gameId)
        {
            var cmd = CommandHelper.CreateText<Game>(text: "SELECT * FROM Game WHERE Id=@id");
            cmd.Params.Add(CommandHelper.CreateParam("@id", gameId));

            return DbContext.GetInstance().Execute(cmd).FirstEntity<Game>();
        }

        /// <summary>
        /// 淘汰赛某场次结束，胜者负者进入下一轮正赛或者附加赛
        /// </summary>
        /// <param name="loop"></param>
        /// <returns></returns>
        public static List<GameLoop> EnterNextGameLoop(GameLoop loop)
        {
            List<GameLoop> resultList = new List<GameLoop>();
            if (loop.KnockLoopId.IsNotNullOrEmpty())//抢位赛
            {
                string winTeamId = loop.Score1 > loop.Score2 ? loop.Team1Id : loop.Team2Id;
                var next = GetLoop(loop.KnockLoopId);
                next.SetRowModified();

                //多加条件，防止管理员重覆修改比分造成错误
                if (next.Team1Id.IsNullOrEmpty() || next.Team1Id == loop.Team1Id || next.Team1Id == loop.Team2Id)
                {
                    next.Team1Id = winTeamId.GetId();
                }
                else
                {
                    next.Team2Id = winTeamId.GetId();
                }
                resultList.Add(next);
            }
            else//非抢位赛
            {
                var order = GetGameOrder(loop.OrderId);
                //如果本轮次是淘汰赛
                if (order.KnockoutOption == KnockoutOption.KNOCKOUT.Id)
                {
                    int nextOrderNo = loop.OrderNo % 2 == 0 ? loop.OrderNo / 2 : (loop.OrderNo + 1) / 2;
                    GameLoop nextLoop = null;
                    GameLoop extraLoop = null;
                    if (loop.IsExtra)
                    {
                        //本轮附加赛，并且附加赛未结束
                        if (loop.ExtraWinOrder > 0)
                        {
                            GetExtraNextOrderLoop(loop, order, nextOrderNo, ref nextLoop, ref extraLoop);
                        }
                    }
                    else if (order.NextOrderId.IsNotNullOrEmpty())
                    {
                        //非附加赛，而且存在下一轮
                        GetNextOrderLoop(order, nextOrderNo, ref nextLoop, ref extraLoop);
                    }

                    //设置正赛或者附加赛参与者TeamId
                    if (nextLoop.IsNotNull() || extraLoop.IsNotNull())
                    {
                        SetNextOrderLoop(loop, resultList, nextLoop, extraLoop);
                    }
                }
            }
            return resultList;
        }

        private static void GetNextOrderLoop(GameOrder order, int nextOrderNo, ref GameLoop nextLoop, ref GameLoop extraLoop)
        {
            //下一步正赛轮次
            var cmdWinLoop = CommandHelper.CreateText<GameLoop>(text: "SELECT * FROM dbo.GameLoop WHERE OrderId=@OrderId AND OrderNo=@OrderNo AND IsExtra = 0");
            cmdWinLoop.Params.Add(CommandHelper.CreateParam("@OrderId", order.NextOrderId));
            cmdWinLoop.Params.Add(CommandHelper.CreateParam("@OrderNo", nextOrderNo));
            nextLoop = DbContext.GetInstance().Execute(cmdWinLoop).Entities.FirstOrDefault() as GameLoop;

            //如果本轮存在附加赛，负者进入附加赛第一轮
            if (order.IsExtra)
            {
                var cmdFailLoop = CommandHelper.CreateText<GameLoop>(text: "SELECT * FROM dbo.GameLoop "
                    + " WHERE OrderId=@OrderId AND OrderNo=@OrderNo AND ExtraOrder = 1 AND IsExtra = 1");
                cmdFailLoop.Params.Add(CommandHelper.CreateParam("@OrderId", order.Id));
                cmdFailLoop.Params.Add(CommandHelper.CreateParam("@OrderNo", nextOrderNo));
                extraLoop = DbContext.GetInstance().Execute(cmdFailLoop).Entities.FirstOrDefault() as GameLoop;
            }
        }

        private static void GetExtraNextOrderLoop(GameLoop loop, GameOrder order, int nextOrderNo, ref GameLoop winLoop, ref GameLoop failLoop)
        {
            var cmdWinLoop = CommandHelper.CreateText<GameLoop>(text: "SELECT * FROM dbo.GameLoop "
                    + " WHERE OrderId=@OrderId AND OrderNo=@OrderNo AND (ExtraOrder = @ExtraWinOrder OR ExtraOrder = @ExtraFailOrder) AND IsExtra = 1");
            cmdWinLoop.Params.Add(CommandHelper.CreateParam("@OrderId", order.Id));
            cmdWinLoop.Params.Add(CommandHelper.CreateParam("@OrderNo", nextOrderNo));
            cmdWinLoop.Params.Add(CommandHelper.CreateParam("@ExtraWinOrder", loop.ExtraWinOrder));
            cmdWinLoop.Params.Add(CommandHelper.CreateParam("@ExtraFailOrder", loop.ExtraFailOrder));
            var result = DbContext.GetInstance().Execute(cmdWinLoop).Entities.ToList<EntityBase, GameLoop>();
            winLoop = result.First(p => p.ExtraOrder == loop.ExtraWinOrder);
            failLoop = result.First(p => p.ExtraOrder == loop.ExtraFailOrder);
        }

        private static void SetNextOrderLoop(GameLoop currentLoop, List<GameLoop> resultList, GameLoop nextLoop, GameLoop extraLoop)
        {
            string winId = currentLoop.Score1 > currentLoop.Score2 ? currentLoop.Team1Id : currentLoop.Team2Id;
            string failId = currentLoop.Score1 > currentLoop.Score2 ? currentLoop.Team2Id : currentLoop.Team1Id;

            if (nextLoop.IsNotNull() && winId.IsNotNullOrEmpty())
            {
                SetNextLoopTeamId(nextLoop, currentLoop, winId);
                nextLoop.SetRowModified();
                resultList.Add(nextLoop);
            }

            if (extraLoop.IsNotNull() && failId.IsNotNullOrEmpty())
            {
                SetNextLoopTeamId(extraLoop, currentLoop, failId);
                extraLoop.SetRowModified();
                resultList.Add(extraLoop);
            }
        }

        private static void SetNextLoopTeamId(GameLoop nextLoop, GameLoop currentLoop, string teamId)
        {
            if (nextLoop.Team1Id == currentLoop.Team1Id || nextLoop.Team1Id == currentLoop.Team2Id)//修改比分重设，修改原位置上的人
            {
                nextLoop.Team1Id = teamId;
            }
            else if (nextLoop.Team2Id == currentLoop.Team1Id || nextLoop.Team2Id == currentLoop.Team2Id)//修改比分重设，修改原位置上的人
            {
                nextLoop.Team2Id = teamId;
            }
            else if (nextLoop.Team1Id.IsNullOrEmpty())//新设
            {
                nextLoop.Team1Id = teamId;
            }
            else if (nextLoop.Team2Id.IsNullOrEmpty())//新设
            {
                nextLoop.Team2Id = teamId;
            }
        }

        /// <summary>
        /// 获取某大轮次
        /// </summary>
        /// <param name="orderId"></param>
        /// <returns></returns>
        public static GameOrder GetGameOrder(string orderId)
        {
            var cmd = CommandHelper.CreateText<GameOrder>(text: "SELECT * FROM dbo.GameOrder WHERE Id=@OrderId");
            cmd.Params.Add(CommandHelper.CreateParam("@OrderId", orderId));
            var result = DbContext.GetInstance().Execute(cmd);
            return result.Entities.FirstOrDefault() as GameOrder;
        }

        /// <summary>
        /// 获取某大轮次
        /// </summary>
        /// <param name="loopId"></param>
        /// <returns></returns>
        public static GameOrder GetGameOrderByLoop(string loopId)
        {
            var cmd = CommandHelper.CreateText<GameOrder>(text: "SELECT * FROM dbo.GameOrder WHERE Id=(SELECT OrderId FROM GameLoop WHERE Id=@loopId)");
            cmd.Params.Add(CommandHelper.CreateParam("@loopId", loopId));
            var result = DbContext.GetInstance().Execute(cmd);
            return result.Entities.FirstOrDefault() as GameOrder;
        }
        /// <summary>
        /// 获取某轮次团队详情比分(只针对团队比赛)
        /// </summary>
        /// <param name="loopId"></param>
        /// <returns></returns>
        public static List<GameLoopDetail> GetLoopMapByLoop(string loopId)
        {
            string sqlStr = @"SELECT LoopId,Id AS MapId,IsTeam,CONCAT(Team1Id,',',User1Name) AS Team1Id,CONCAT(Team2Id,',',User2Name) AS Team2Id, Game1 AS Fen1,Game2 AS Fen2,OrderNo FROM GameLoopMap WHERE LoopId=@loopId ORDER BY OrderNo";
            var cmd = CommandHelper.CreateText<GameLoopDetail>(FetchType.Fetch, sqlStr);
            cmd.Params.Add(CommandHelper.CreateParam("@loopId", loopId));
            var result = DbContext.GetInstance().Execute(cmd);
            return result.Entities.ToList<EntityBase, GameLoopDetail>();
        }
        /// <summary>
        /// 根据对阵队员ID,获取技能积分
        /// </summary>
        /// <param name="userid">双打时,用户ID,以逗号隔开</param>
        /// <returns></returns>
        public static string GetSportScoreByUser(string userid)
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            if (userid.Contains(","))
            {
                string[] temp = userid.Split(',');
                for(int i = 0; i < temp.Length; i++)
                {
                    string tempStr = GetSportScore(temp[i]);
                    sb.Append(tempStr);
                    sb.Append(",");
                }
            }
            else
            {
                sb.Append(GetSportScore(userid));
            }
            return sb.ToString().TrimEnd(',');
        }
        private static string GetSportScore(string userid)
        {
            string result = string.Empty;
            var cmd = CommandHelper.CreateProcedure<UserSport>(FetchType.Fetch, "sp_GetUserSportList");
            cmd.Params.Add(CommandHelper.CreateParam("@userId", userid));
            cmd.Params.Add(CommandHelper.CreateParam("@sportId", null));
            var res = DbContext.GetInstance().Execute(cmd);
            if (res.Entities != null && res.Entities.Count > 0)
            {
                result = ((UserSport)res.Entities[0]).Score.ToString();
            }
            return result;
        }
        /// <summary>
        /// 获取赛事对象
        /// </summary>
        /// <param name="gameId"></param>
        /// <returns></returns>
        public static Game GetSingleGame(string gameId)
        {
            Game result = null;
            var cmd = CommandHelper.CreateText<Game>(FetchType.Fetch, @"SELECT * FROM Game WHERE Id=@gameId");
            cmd.Params.Add(CommandHelper.CreateParam("@gameId", gameId));
            var res = DbContext.GetInstance().Execute(cmd);
            if (res.Entities != null && res.Entities.Count > 0)
            {
                result = res.Entities[0] as Game;
            }
            return result;
        }
    }
}
