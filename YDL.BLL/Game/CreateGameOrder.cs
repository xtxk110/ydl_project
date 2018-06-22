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
    /// 定义首轮，并自动创建剩下轮次，可以形成拓扑图(小组赛不创建，创建淘汰赛轮次的所有比赛，附加赛)
    /// </summary>
    public class CreateGameOrder : IServiceBase
    {
        /// <summary>
        /// 定义首轮，并自动创建剩下轮次，可以形成拓扑图(小组赛不创建，创建淘汰赛轮次的所有比赛，附加赛)
        /// </summary>
        /// <param name="request">Request.GameOrder.Entities</param>
        /// <returns>Response.EmptyEntity</returns>
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GameOrder>>(request);

            var firstOrder = req.FirstEntity();
            if (firstOrder.RowState == RowState.Added)
            {
                firstOrder.SetNewId();
                firstOrder.SetCreateDate();
                firstOrder.State = GameOrderState.NOTSTART.Id;
            }
            var entities = new List<EntityBase> { firstOrder };

            var game = GameHelper.GetGame(firstOrder.GameId);

            //设置第一轮KnockoutOption
            firstOrder.IsTeam = game.IsTeam;
            firstOrder.KnockoutOption = game.KnockoutOption == KnockoutOption.ROUND_KNOCKOUT.Id ? KnockoutOption.ROUND.Id : game.KnockoutOption;

            if (game.KnockoutOption == KnockoutOption.ROUND.Id)
            {
                //单循环赛
                var filter = new GetGameTeamListFilter { GameId = game.Id, PageIndex = 1, PageSize = 10000 };
                var teamList = GameHelper.GetGameTeamList(filter).Entities.ToList<EntityBase, GameTeam>();
                if (teamList.Count < 2)
                {
                    return ResultHelper.Fail("至少2支参赛队才能建立单循环赛！");
                }
                CreateSingleRound(firstOrder, entities, game, teamList);
            }
            else
            {
                //单淘汰赛，先循环后淘汰赛

                //设置AB模式选项
                firstOrder.SetKnockOutAB(game.IsKnockOutAB);

                //验证数据
                var valResult = Validate(game, firstOrder);
                if (!valResult.IsSuccess)
                {
                    return ResultHelper.Fail(valResult.Message);
                }

                //设置第一轮数据
                int orderNo = 1;//大轮次序号，从1开始
                firstOrder.OrderNo = orderNo;
                firstOrder.Name = string.Format(firstOrder.KnockoutOption == KnockoutOption.ROUND.Id ? "小组赛" : "1/{1}决赛", firstOrder.OrderNo, firstOrder.GroupCount);

                //创建轮次，正常比赛，附加赛，合并数据
                var loopEntities = new List<EntityBase>();
                var groupEntities = new List<EntityBase>();
                var extraEntities = new List<EntityBase>();
                CreateMoreOrderAndLoop(req, entities, firstOrder, game, orderNo, loopEntities, groupEntities);

                //初始化轮次计分模式
                entities.ForEach(p => (p as GameOrder).TeamScoreMode = TeamScoreMode.STANDARD.Id);

                if (firstOrder.TopNumber > 0)
                {
                    //决出名次验证
                    if (entities.Count < Math.Log(firstOrder.TopNumber, 2))
                    {
                        return ResultHelper.Fail("决出名次大于轮次可决出名次。");
                    }
                    CreateExtraGame(game, entities, firstOrder.TopNumber, extraEntities);
                }
                MergeData(entities, loopEntities, groupEntities, extraEntities);
            }
            //创建保存命令，并加入删除之前数据命令
            var cmdDelete = CommandHelper.CreateProcedure(FetchType.Execute, "sp_DeleteGameAllDetail");
            cmdDelete.Params.Add("@gameId", firstOrder.GameId);

            var cmdSave = CommandHelper.CreateSave(entities);
            cmdSave.PreCommands.Add(cmdDelete);

            return DbContext.GetInstance().Execute(cmdSave);
        }

        private static void CreateSingleRound(GameOrder firstOrder, List<EntityBase> entities, Game game, List<GameTeam> teamList)
        {
            firstOrder.OrderNo = 1;
            firstOrder.Name = "单循环赛";

            var group = new GameGroup { Name = "单循环组", GameId = game.Id, IsTeam = game.IsTeam, OrderNo = 1, LeaderId = game.CreatorId, OrderId = firstOrder.Id, MemberList = new List<GameGroupMember>() };
            group.SetNewEntity();
            //构建单分组
            entities.Add(group);

            int memberOrderNo = 0;
            teamList.ForEach(p =>
            {
                memberOrderNo++;
                var member = new GameGroupMember { TeamId = p.Id, GameId = firstOrder.GameId, GroupId = group.Id, IsTeam = firstOrder.IsTeam, OrderNo = memberOrderNo };
                member.SetNewEntity();
                group.MemberList.Add(member);
            });

            //构建分组成员
            SaveGameGroup.CreateOneGroupMembers(entities, group);
            //构建单循环比赛
            SaveGameGroup.CreateOneGroupLoops(entities, group);
        }

        private ValidationResult Validate(Game game, GameOrder firstOrder)
        {
            var result = new ValidationResult { IsSuccess = true };
            if (firstOrder.KnockoutOption == KnockoutOption.ROUND.Id)
            {
                if (firstOrder.KnockoutCount < 2)
                {
                    result.IsSuccess = false;
                    result.Message = "请选择前2名或者前4名出线。";
                }

                if (game.IsKnockOutAB && firstOrder.KnockoutCount < 4)
                {
                    result.IsSuccess = false;
                    result.Message = "已启用淘汰阶段AB组模式，请选择前4名出线。";
                }
            }
            else
            {
                //单淘汰第一轮设置KnockOutAB
                firstOrder.KnockOutAB = KnockOutAB.A;
            }

            if (firstOrder.KnockoutTotal == 0)
            {
                result.IsSuccess = false;
                result.Message = "请选择淘汰赛第一轮总人数。";
            }
            return result;
        }

        private static void CreateMoreOrderAndLoop(Request<GameOrder> req, List<EntityBase> entities, GameOrder firstOrder, Game game, int orderNo, List<EntityBase> loopEntities, List<EntityBase> groupEntities)
        {
            if (game.KnockoutOption == KnockoutOption.KNOCKOUT.Id || game.KnockoutOption == KnockoutOption.ROUND_KNOCKOUT.Id)
            {
                if (firstOrder.KnockoutOption == KnockoutOption.KNOCKOUT.Id)
                {
                    CreateOrderLoops(firstOrder, loopEntities);//单淘汰第一轮生成比赛场次表
                }
                else
                {
                    createGameGroup(firstOrder, groupEntities);//先循环后淘汰第一轮生成小组分组表
                }
                CreateMoreOrder(game, firstOrder, entities, orderNo, loopEntities);//生成第二轮及后面大轮次及轮次比赛场次表，按照1/2递进
            }
        }

        private static void MergeData(List<EntityBase> entities, List<EntityBase> loopEntities, List<EntityBase> groupEntities, List<EntityBase> extraEntities)
        {
            //entities本身已经包含轮次
            //合并淘汰比赛场次数据
            if (loopEntities.IsNotNullOrEmpty())
            {
                entities.AddRange(loopEntities);
            }
            //合并附加赛场次数据
            if (extraEntities.IsNotNullOrEmpty())
            {
                entities.AddRange(extraEntities);
            }
            //合并小组分组数据
            if (groupEntities.IsNotNullOrEmpty())
            {
                entities.AddRange(groupEntities);
            }
        }

        private static void CreateExtraGame(Game game, List<EntityBase> entities, int topNumber, List<EntityBase> extraEntities)
        {
            var allOrders = entities.ToList<EntityBase, GameOrder>();
            CreateOneExtras(KnockOutAB.A, topNumber, extraEntities, allOrders);
            if (game.IsKnockOutAB)
            {
                //创建B组附加赛
                CreateOneExtras(KnockOutAB.B, topNumber, extraEntities, allOrders);
            }
        }

        private static void CreateOneExtras(string knockOutAB, int topNumber, List<EntityBase> extraEntities, List<GameOrder> allOrders)
        {
            foreach (var order in allOrders.Where(p => p.KnockOutAB == knockOutAB))
            {
                //决赛没有附加赛
                if (order.KnockoutTotal > 2 && order.KnockoutTotal <= topNumber)
                {
                    //设置轮次存在附加赛标记
                    order.IsExtra = true;

                    var extraGame = new ExtraGame();
                    extraGame.Create(order.EndRank / 2, extraEntities, order, order.EndRank / 2 + 1, order.EndRank);
                }
            }
        }

        private static void CreateMoreOrder(Game game, GameOrder firstOrder, List<EntityBase> entities, int orderNo, List<EntityBase> loopEntities)
        {
            int orderCount = firstOrder.KnockoutOption == KnockoutOption.KNOCKOUT.Id ? firstOrder.KnockoutTotalAB / 4 : firstOrder.KnockoutTotalAB / 2;
            GameOrder preOrderA = firstOrder;
            GameOrder preOrderB = firstOrder;
            while (orderCount >= 1)
            {
                orderNo++;
                //大轮次
                GameOrder orderA = CreateOneGameOrder(orderNo, orderCount, preOrderA);
                orderA.KnockOutAB = KnockOutAB.A;
                entities.Add(orderA);

                //设置前轮次下轮次-即本轮
                preOrderA.NextOrderId = orderA.Id;

                //生成大轮次比赛场次列表
                CreateOrderLoops(orderA, loopEntities);

                preOrderA = orderA;

                //生成淘汰B组
                if (game.IsKnockOutAB)
                {
                    GameOrder orderB = CreateOneGameOrder(orderNo, orderCount, preOrderB);
                    orderB.KnockOutAB = KnockOutAB.B;
                    entities.Add(orderB);
                    if (preOrderB == firstOrder)
                    {
                        //设置第一轮B组后续轮次Id
                        preOrderB.NextOrderBId = orderB.Id;
                    }
                    else
                    {
                        preOrderB.NextOrderId = orderB.Id;
                    }
                    CreateOrderLoops(orderB, loopEntities);
                    preOrderB = orderB;
                }
                //处理循环变量
                orderCount = orderCount / 2;
            }
        }

        private static GameOrder CreateOneGameOrder(int orderNo, int count, GameOrder preOrder)
        {
            GameOrder order = new GameOrder();
            order.SetNewId();
            order.SetCreateDate();
            order.SetRowAdded();

            order.IsTeam = preOrder.IsTeam;
            order.GameId = preOrder.GameId;
            order.PreOrderId = preOrder.Id;//前轮次
            order.OrderNo = orderNo;//当前轮次
            order.Name = string.Format(count > 1 ? "1/{1}决赛" : "决赛", order.OrderNo, count);
            order.KnockoutOption = KnockoutOption.KNOCKOUT.Id;//淘汰制度
            order.KnockoutCount = 1;
            order.GroupCount = count;
            order.KnockoutTotal = count * 2;
            order.State = GameOrderState.NOTSTART.Id;
            return order;
        }

        private static void createGameGroup(GameOrder firstOrder, List<EntityBase> groupEntities)
        {
            for (int i = 1; i <= firstOrder.GroupCount; i++)
            {
                GameGroup group = new GameGroup();
                group.SetCreateDate();
                group.SetNewId();
                group.SetRowAdded();

                group.GameId = firstOrder.GameId;
                group.IsTeam = firstOrder.IsTeam;
                group.Name = string.Format("第{0}组", i);
                group.OrderId = firstOrder.Id;
                group.OrderNo = i;
                groupEntities.Add(group);
            }
        }

        private static void CreateOrderLoops(GameOrder current, List<EntityBase> entities)
        {
            for (int i = 1; i <= current.GroupCount; i++)
            {
                current.BeginRank = 1;
                current.EndRank = current.GroupCount * 2;

                var loop = createLoopGame(current, i, 1, current.GroupCount * 2);
                entities.Add(loop);
            }
        }

        private static GameLoop createLoopGame(GameOrder current, int i, int beginRank, int endRank)
        {
            GameLoop loop = new GameLoop();
            loop.SetNewId();
            loop.SetCreateDate();
            loop.SetRowAdded();

            loop.OrderId = current.Id;
            loop.OrderNo = i;//淘汰赛为序号，小组赛为轮次
            loop.GameId = current.GameId;

            loop.GroupId = null;
            loop.Team1Id = null;
            loop.Team2Id = null;

            loop.BeginRank = beginRank;
            loop.EndRank = endRank;
            loop.IsTeam = current.IsTeam;
            loop.State = GameLoopState.NOTSTART.Id;
            loop.IsBye = false;//轮空标志
            loop.IsExtra = false;//非附加赛
            return loop;
        }


    }
}
