using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using YDL.Model;
using YDL.BLL;
using YDL.Map;
using YDL.Core;
using YDL.Utility;

namespace YDL.Web
{
    public class GameController : ControllerLimit
    {
        [HttpGet]
        public ActionResult GameOperation(string clubId = "", string id = "")
        {
            try
            {
                if (!CurrentUser.UserLimit.IsGame)
                    throw new Exception("您没有权限");

                Game game;
                //新增
                if (string.IsNullOrEmpty(id))
                {
                    game = new Game();
                    game.ClubId = clubId;
                }
                else
                {
                    Request<Game> request = new Request<Game>();
                    request.Filter = new Game { Id = id };
                    request.Token = CurrentUser.Token;

                    var result = ServiceBuilder.GetInstance().Execute(ServiceType.GetGame, request);
                    game = result.Entities.FirstOrDefault() as Game;
                }

                //俱乐部档位
                ViewBag.Club = new Club();
                if (!string.IsNullOrEmpty(clubId))
                {
                    Request<Club> reqClub = new Request<Club>();
                    reqClub.Filter = new Club { Id = clubId };
                    reqClub.Token = CurrentUser.Token;

                    var resClub = ServiceBuilder.GetInstance().Execute(ServiceType.GetClub, reqClub);
                    ViewBag.Club = resClub.Entities.FirstOrDefault() as Club;
                }

                //城市
                Request<City> reqCity = new Request<City>();
                reqCity.Token = CurrentUser.Token;
                var resCity = ServiceBuilder.GetInstance().Execute(ServiceType.GetCityList, reqCity);
                ViewBag.CityLst = resCity.Entities;

                return View(game);
            }
            catch (Exception ex)
            {
                return this.RedirectToErrorPage(ex.Message);
            }
        }

        [HttpPost]
        public JsonResult GameOperationSave(Game game)
        {
            try
            {
                game.State = GameState.NOTSTART.Id;
                game.RowState = string.IsNullOrEmpty(game.Id) ? RowState.Added : RowState.Modified;
                Request<Game> request = new Request<Game>();
                request.Token = CurrentUser.Token;
                request.Entities = new List<Game> { game };

                var result = ServiceBuilder.GetInstance().Execute(ServiceType.SaveGame, request);

                return ToJson(result);
            }
            catch (Exception ex)
            {
                var errResult = ResultHelper.Fail(ex.Message);
                return ToJson(errResult);
            }
        }

        [HttpGet]
        public ActionResult GameList()
        {
            try
            {
                return View();
            }
            catch (Exception ex)
            {
                return this.RedirectToErrorPage(ex.Message);
            }
        }

        [HttpPost]
        public JsonResult GameListFilter(string gameName, string clubId = "", int pageIndex = 1)
        {
            try
            {
                Request<GetGameListFilter> request = new Request<GetGameListFilter>();
                request.Token = CurrentUser.Token;
                request.Filter = new GetGameListFilter { ClubId = clubId, GameName = gameName, IsOnlySelf = false, PageIndex = pageIndex, PageSize = ViewHelper.PageSize };
                var result = ServiceBuilder.GetInstance().Execute(ServiceType.GetGameList, request);

                return ToJson(result);
            }
            catch (Exception ex)
            {
                var errResult = ResultHelper.Fail(ex.Message);
                return ToJson(errResult);
            }
        }

        [HttpGet]
        public ActionResult Detail(string gameId)
        {
            try
            {
                Request<Game> request = new Request<Game>();
                request.Filter = new Game { Id = gameId };
                request.Token = CurrentUser.Token;

                var result = ServiceBuilder.GetInstance().Execute(ServiceType.GetGame, request);
                var game = result.Entities.FirstOrDefault() as Game;

                return View(game);
            }
            catch (Exception ex)
            {
                return this.RedirectToErrorPage(ex.Message);
            }
        }

        [HttpGet]
        public ActionResult GameTeamList(string gameId, bool canOper = false)
        {
            try
            {
                ViewBag.GameId = gameId;
                ViewBag.CanOper = canOper;

                return View();
            }
            catch (Exception ex)
            {
                return this.RedirectToErrorPage(ex.Message);
            }
        }

        [HttpPost]
        public JsonResult GameTeamListData(string gameId, string state = "", int pageIndex = 1)
        {
            try
            {
                var request = new Request<GetGameTeamListFilter>();
                request.Token = CurrentUser.Token;
                request.Filter = new GetGameTeamListFilter { GameId = gameId, State = state, OnlyNotGroup = false, PageIndex = pageIndex, PageSize = ViewHelper.PageSize };
                var result = ServiceBuilder.GetInstance().Execute(ServiceType.GetGameTeamList, request);

                return ToJson(result);
            }
            catch (Exception ex)
            {
                var errResult = ResultHelper.Fail(ex.Message);
                return ToJson(errResult);
            }
        }

        [HttpGet]
        public ActionResult GameTeamCheck(string Id)
        {
            try
            {
                Request<GameTeam> request = new Request<GameTeam>();
                request.Token = CurrentUser.Token;
                request.Filter = new GameTeam { Id = Id };
                var result = ServiceBuilder.GetInstance().Execute(ServiceType.GetGameTeam, request);
                var gameTeam = result.Entities.FirstOrDefault() as GameTeam;

                return View(gameTeam);
            }
            catch (Exception ex)
            {
                return this.RedirectToErrorPage(ex.Message);
            }
        }

        [HttpPost]
        public JsonResult GameTeamCheckSave(string id, string auditRemark, string state)
        {
            try
            {
                Request<GameTeam> request = new Request<GameTeam>();
                request.Token = CurrentUser.Token;
                request.Entities = new List<GameTeam> { new GameTeam { 
                    Id = id, 
                    AuditorId = CurrentUser.Id, 
                    AuditRemark = auditRemark,
                    AuditDate = DateTime.Now,
                    State = state} };

                var result = ServiceBuilder.GetInstance().Execute(ServiceType.AuditGameTeam, request);

                return ToJson(result);
            }
            catch (Exception ex)
            {
                var errResult = ResultHelper.Fail(ex.Message);
                return ToJson(errResult);
            }
        }

        [HttpPost]
        public JsonResult GameTeamReCheck(string id, string name)
        {
            try
            {
                Request<GameTeam> request = new Request<GameTeam>();
                request.Token = CurrentUser.Token;
                request.Entities = new List<GameTeam>() { new GameTeam { Id = id, TeamName = name } };

                var result = ServiceBuilder.GetInstance().Execute(ServiceType.ReversalGameTeam, request);

                return ToJson(result);
            }
            catch (Exception ex)
            {
                var errResult = ResultHelper.Fail(ex.Message);
                return ToJson(errResult);
            }
        }

        [HttpGet]
        public ActionResult GameTeamUpdate(string Id)
        {
            try
            {
                Request<GameTeam> request = new Request<GameTeam>();
                request.Token = CurrentUser.Token;
                request.Filter = new GameTeam { Id = Id };
                var result = ServiceBuilder.GetInstance().Execute(ServiceType.GetGameTeam, request);
                var gameTeam = result.Entities.FirstOrDefault() as GameTeam;

                return View(gameTeam);
            }
            catch (Exception ex)
            {
                return this.RedirectToErrorPage(ex.Message);
            }
        }

        [HttpPost]
        public JsonResult GameTeamUpdateSave(GameTeam team)
        {
            try
            {
                team.RowState = RowState.Modified;
                Request<GameTeam> request = new Request<GameTeam>();
                request.Token = CurrentUser.Token;
                request.Entities = new List<GameTeam> { team };

                var result = ServiceBuilder.GetInstance().Execute(ServiceType.AuditGameTeam, request);

                return ToJson(result);
            }
            catch (Exception ex)
            {
                var errResult = ResultHelper.Fail(ex.Message);
                return ToJson(errResult);
            }
        }

        [HttpPost]
        public JsonResult TeamRemove(string id, string gameId)
        {
            try
            {
                Request<GameTeam> request = new Request<GameTeam>();
                request.Token = CurrentUser.Token;
                request.Filter = new GameTeam
                {
                    Id = id,
                    GameId = gameId
                };

                var result = ServiceBuilder.GetInstance().Execute(ServiceType.DeleteGameTeamById, request);

                return ToJson(result);
            }
            catch (Exception ex)
            {
                var errResult = ResultHelper.Fail(ex.Message);
                return ToJson(errResult);
            }
        }

        [HttpPost]
        public JsonResult GameTeamSeedSave(GameTeam team)
        {
            try
            {
                Request<GameTeam> request = new Request<GameTeam>();
                request.Token = CurrentUser.Token;
                request.Entities = new List<GameTeam> { team };

                var result = ServiceBuilder.GetInstance().Execute(ServiceType.SaveGameTeamSeed, request);

                return ToJson(result);
            }
            catch (Exception ex)
            {
                var errResult = ResultHelper.Fail(ex.Message);
                return ToJson(errResult);
            }
        }

        [HttpGet]
        public ActionResult GameJudgeLst(string gameId)
        {
            try
            {
                ViewBag.GameId = gameId;

                Request<Game> request = new Request<Game>();
                request.Filter = new Game { Id = gameId };
                request.Token = CurrentUser.Token;
                var result = ServiceBuilder.GetInstance().Execute(ServiceType.GetGameJudgeList, request);
                return View(result.Entities);
            }
            catch (Exception ex)
            {
                return this.RedirectToErrorPage(ex.Message);
            }
        }

        [HttpPost]
        public JsonResult GameJudgesSave(List<GameJudge> judges, RowState rState)
        {
            try
            {
                //新增时，排重
                if (rState == RowState.Added)
                {
                    Request<Game> req = new Request<Game>();
                    req.Token = CurrentUser.Token;
                    req.Filter = new Game { Id = judges[0].GameId };
                    var res = ServiceBuilder.GetInstance().Execute(ServiceType.GetGameJudgeList, req);

                    bool flag;
                    judges.ForEach(j => {

                        flag = true;

                        res.Entities.ForEach(p =>
                        {
                            GameJudge o = p as GameJudge;
                            if (o.UserId.GetId() == j.UserId)
                            {
                                flag = false;
                                return;
                            }
                        });

                        if (flag)
                            j.RowState = rState;
                    });
                }
                else
                {
                    judges.ForEach(p => { p.RowState = rState; });
                }

                Request<GameJudge> request = new Request<GameJudge>();
                request.Token = CurrentUser.Token;
                request.Entities = judges;

                var result = ServiceBuilder.GetInstance().Execute(ServiceType.SaveGameJudge, request);

                return ToJson(result);
            }
            catch (Exception ex)
            {
                var errResult = ResultHelper.Fail(ex.Message);
                return ToJson(errResult);
            }
        }

        [HttpGet]
        public ActionResult GameOrderOperation(string gameId, string knockoutId, string stateId, bool isCreator)
        {
            try
            {
                ViewBag.KnockoutId = knockoutId;
                ViewBag.GameStateId = stateId;
                ViewBag.IsCreator = isCreator;

                Request<Game> request = new Request<Game>();
                request.Token = CurrentUser.Token;
                request.Filter = new Game { Id = gameId };
                var result = ServiceBuilder.GetInstance().Execute(ServiceType.GetGameOrderList, request);

                //获取第一轮次信息，主要得到小组数和晋级名次
                GameOrder firstOrder;
                if (result.Entities.Count > 0)
                    firstOrder = result.Entities.FirstOrDefault() as GameOrder;
                else
                    firstOrder = new GameOrder { GameId = gameId, KnockoutOption = knockoutId, GroupCount = 0, KnockoutCount = 0 };

                firstOrder.GroupList = new List<GameGroup>();


                //获取小组列表
                Request<GetGameGroupListFilter> groupReq = new Request<GetGameGroupListFilter>();
                groupReq.Token = CurrentUser.Token;
                groupReq.Filter = new GetGameGroupListFilter { GameId = gameId, IsContainMember = true };
                result = ServiceBuilder.GetInstance().Execute(ServiceType.GetGameGroupList, groupReq);
                if (result.Entities.Count > 0)
                {
                    result.Entities.ForEach(o =>
                    {
                        firstOrder.GroupList.Add(o as GameGroup);
                    });
                }

                return View(firstOrder);
            }
            catch (Exception ex)
            {
                return this.RedirectToErrorPage(ex.Message);
            }
        }


        [HttpPost]
        public JsonResult GameOrderCreate(string gameId, int groupCount, int knockoutCount, string knockoutId)
        {
            try
            {
                Request<GameOrder> request = new Request<GameOrder>();
                request.Token = CurrentUser.Token;
                request.Entities = new List<GameOrder> { 
                    new GameOrder { 
                        GameId = gameId, 
                        GroupCount = groupCount, 
                        KnockoutCount = knockoutCount,
                        KnockoutOption = knockoutId,
                        RowState = RowState.Added
                    } };

                var result = ServiceBuilder.GetInstance().Execute(ServiceType.CreateGameOrder, request);
                return ToJson(result);
            }
            catch (Exception ex)
            {
                var errResult = ResultHelper.Fail(ex.Message);
                return ToJson(errResult);
            }
        }

        [HttpGet]
        public ActionResult GameOrderWinSettings(string orderId, bool isTeam)
        {
            try
            {
                ViewBag.OrderId = orderId;
                ViewBag.IsTeam = isTeam;
                return View();
            }
            catch (Exception ex)
            {
                return this.RedirectToErrorPage(ex.Message);
            }
        }

        [HttpPost]
        public JsonResult GameOrderWinSave(GameOrder order)
        {
            try
            {
                order.RowState = RowState.Modified;

                Request<GameOrder> request = new Request<GameOrder>();
                request.Token = CurrentUser.Token;
                request.Entities = new List<GameOrder>() { order };

                var result = ServiceBuilder.GetInstance().Execute(ServiceType.SaveGameOrderWin, request);

                return ToJson(result);
            }
            catch (Exception ex)
            {
                var errResult = ResultHelper.Fail(ex.Message);
                return ToJson(errResult);
            }
        }

        [HttpGet]
        public ActionResult GameStateUpdate(string gameId, string stateId)
        {
            try
            {
                var curState = GameState.Find(stateId);
                BaseData nextState = null;
                if (curState != GameState.FINISH
                    && curState != GameState.CANCEL)
                {
                    nextState = GameState.Find(curState.Tag.ToString());
                }

                ViewBag.CurSate = curState;
                ViewBag.NextState = nextState;
                ViewBag.GameId = gameId;
                return View();
            }
            catch (Exception ex)
            {
                return this.RedirectToErrorPage(ex.Message);
            }
        }

        [HttpPost]
        public JsonResult GameStateUpdateSave(string gameId, string stateId)
        {
            try
            {
                Request<Game> request = new Request<Game>();
                request.Token = CurrentUser.Token;
                request.Entities = new List<Game> { new Game { Id = gameId, State = stateId } };

                var result = ServiceBuilder.GetInstance().Execute(ServiceType.SaveGameState, request);

                return ToJson(result);
            }
            catch (Exception ex)
            {
                var errResult = ResultHelper.Fail(ex.Message);
                return ToJson(errResult);
            }
        }

        [HttpPost]
        public JsonResult GameGroupList(string gameId)
        {
            try
            {
                Request<GetGameGroupListFilter> request = new Request<GetGameGroupListFilter>();
                request.Token = CurrentUser.Token;
                request.Filter = new GetGameGroupListFilter { GameId = gameId, IsContainMember = false };

                var result = ServiceBuilder.GetInstance().Execute(ServiceType.GetGameGroupList, request);

                return ToJson(result);
            }
            catch (Exception ex)
            {
                var errResult = ResultHelper.Fail(ex.Message);
                return ToJson(errResult);
            }
        }

        /// <summary>
        /// 拓扑图
        /// </summary>
        /// <param name="gameId"></param>
        /// <param name="knockoutId"></param>
        /// <returns></returns>
        [HttpGet]
        public ActionResult GameOrderTopology(double firstCount, string gameId)
        {
            try
            {
                ViewBag.FirstCount = firstCount;

                //比赛轮次
                Request<Game> reqOrder = new Request<Game>();
                reqOrder.Token = CurrentUser.Token;
                reqOrder.Filter = new Game { Id = gameId };
                var resOrder = ServiceBuilder.GetInstance().Execute(ServiceType.GetGameOrderList, reqOrder);
                var lst = (from p in resOrder.Entities where (p as GameOrder).KnockoutOption == KnockoutOption.KNOCKOUT.Id select p as GameOrder).ToList();
                ViewBag.GameOrderLst = lst;

                //比赛对阵详情
                Request<GetGameOrderLoopListFilter> request = new Request<GetGameOrderLoopListFilter>();
                request.Token = CurrentUser.Token;
                request.Filter = new GetGameOrderLoopListFilter { GameId = gameId, IsExtra = "0" };
                var result = ServiceBuilder.GetInstance().Execute(ServiceType.GetGameOrderLoopList, request);

                return View(result.Entities);
            }
            catch (Exception ex)
            {
                return this.RedirectToErrorPage(ex.Message);
            }
        }

        [HttpGet]
        public ActionResult GameLoopDetail(string loopId)
        {
            try
            {
                Request<GetGameLoopDetailListFilter> request = new Request<GetGameLoopDetailListFilter>();
                request.Token = CurrentUser.Token;
                request.Filter = new GetGameLoopDetailListFilter { LoopId = loopId };
                var result = ServiceBuilder.GetInstance().Execute(ServiceType.GetGameLoopDetailList, request);

                return View(result.Entities);
            }
            catch (Exception ex)
            {
                return this.RedirectToErrorPage(ex.Message);
            }
        }

        /// <summary>
        /// 抽签
        /// </summary>
        /// <param name="gameId"></param>
        /// <returns></returns>
        [HttpGet]
        public ActionResult GameOrderTakeout(string gameId)
        {
            try
            {
                ViewBag.GameId = gameId;
                //参赛队伍
                var teamReq = new Request<GetGameTeamListFilter>();
                teamReq.Token = CurrentUser.Token;
                teamReq.Filter = new GetGameTeamListFilter { GameId = gameId, State = GameTeamState.PASS.Id, OnlyNotGroup = true, PageIndex = 1, PageSize = 1000 };
                var teamRes = ServiceBuilder.GetInstance().Execute(ServiceType.GetGameTeamList, teamReq);
                List<GameTeam> seekTeams, noseekTeams;
                seekTeams = (from p in teamRes.Entities where (p as GameTeam).IsSeed select p as GameTeam).ToList();
                noseekTeams = (from p in teamRes.Entities where !(p as GameTeam).IsSeed select p as GameTeam).ToList();

                Random rand = new Random();
                seekTeams.Sort((l, r) =>
                {
                    return rand.Next(3) - 1;
                });
                noseekTeams.Sort((l, r) =>
                {
                    return rand.Next(3) - 1;
                });

                ViewBag.SeekTeams = seekTeams;
                ViewBag.NoseekTeams = noseekTeams;

                //小组信息
                var request = new Request<GetGameGroupListFilter>();
                request.Token = CurrentUser.Token;
                request.Filter = new GetGameGroupListFilter { GameId = gameId, IsContainMember = true };

                var result = ServiceBuilder.GetInstance().Execute(ServiceType.GetGameGroupList, request);
                return View(result.Entities);
            }
            catch (Exception ex)
            {
                return this.RedirectToErrorPage(ex.Message);
            }
        }

        [HttpPost]
        public JsonResult GameOrderTakeoutSave(List<GameGroup> groups)
        {
            try
            {
                Request<GameGroup> request = new Request<GameGroup>();
                request.Token = CurrentUser.Token;
                request.Entities = groups;

                var result = ServiceBuilder.GetInstance().Execute(ServiceType.SaveGameGroup, request);

                return ToJson(result);
            }
            catch (Exception ex)
            {
                var errResult = ResultHelper.Fail(ex.Message);
                return ToJson(errResult);
            }
        }

        [HttpGet]
        public ActionResult SameunitSet(string gameId, string teamId ,string teamName)
        {
            try
            {
                List<GameTeam> lst = new List<GameTeam>();

                var request = new Request<GetGameTeamListFilter>();
                request.Token = CurrentUser.Token;
                request.Filter = new GetGameTeamListFilter { GameId = gameId, OnlyNotGroup = false, PageIndex = 1, PageSize = 1000 };
                var result = ServiceBuilder.GetInstance().Execute(ServiceType.GetGameTeamList, request);
                result.Entities.ForEach(p =>
                {
                    if (p.Id != teamId)
                        lst.Add(p as GameTeam);
                });

                ViewBag.GameId = gameId;
                ViewBag.TeamId = teamId;
                ViewBag.TeamName = teamName;
                return View(lst);
            }
            catch (Exception ex)
            {
                return this.RedirectToErrorPage(ex.Message);
            }
        }

        [HttpPost]
        public JsonResult SameunitSave(GameTeam team)
        {
            try
            {
                Request<GameTeam> request = new Request<GameTeam>();
                request.Token = CurrentUser.Token;
                request.Entities = new List<GameTeam> { team };

                var result = ServiceBuilder.GetInstance().Execute(ServiceType.UpdateGameCorpTeamId, request);
                return ToJson(result);
            }
            catch (Exception ex)
            {
                var errResult = ResultHelper.Fail(ex.Message);
                return ToJson(errResult);
            }
        }
    }
}