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
    /// 第二轮淘汰赛，获取按人抽签位置列表
    /// </summary>
    public class GetGamePositionList : IService
    {
        /// <summary>
        /// 第二轮淘汰赛，获取按人抽签位置列表
        /// </summary>
        /// <param name="request">Request.GameOrder.Entities</param>
        /// <returns>Response.EmptyEntity</returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GameOrder>>(request);

            var firstOrder = GameHelper.GetGameOrder(req.Filter.Id);
            firstOrder.CalAllPosition = req.Filter.CalAllPosition;
            firstOrder.SeedList = req.Filter.SeedList;
            firstOrder.KnockOutAB = req.Filter.KnockOutAB.IsNotNullOrEmpty() ? req.Filter.KnockOutAB : KnockOutAB.A;

            //设置AB选项
            var game = GameHelper.GetGame(firstOrder.GameId);
            firstOrder.SetKnockOutAB(game.IsKnockOutAB);

            //第一次检查小组赛是否结束，是否已计算排名或已经抽过签（AB组分开验证）
            if (!firstOrder.CalAllPosition)
            {
                var cmdValidate = CommandHelper.CreateProcedure(FetchType.Execute, "sp_CheckGameGroupState");
                cmdValidate.Params.Add("@gameId", firstOrder.GameId);
                cmdValidate.Params.Add("@knockOutAB", firstOrder.KnockOutAB);
                cmdValidate.CreateParamMsg();
                var resultVal = DbContext.GetInstance().Execute(cmdValidate);
                //验证失败，返回错误信息
                if (!resultVal.IsSuccess)
                {
                    return resultVal;
                }
            }
            if (firstOrder.CalAllPosition)
            {
                SetPositionListTwo(firstOrder, false);
                CheckSameCorpTeamId(firstOrder);

                //第二次返回所有名次
                firstOrder.MemberList = GetGroupKnockUserList(firstOrder, firstOrder.BeginRankAB, firstOrder.EndRankAB);
            }
            else
            {
                SetPositionListFirst(firstOrder);

                //第一次仅返回第一名
                firstOrder.MemberList = GetGroupKnockUserList(firstOrder, firstOrder.BeginRankAB, firstOrder.BeginRankAB);
            }

            var resultOrder = ResultHelper.Success(new List<EntityBase> { firstOrder });
            return resultOrder;
        }

        public static void CheckSameCorpTeamId(GameOrder order)
        {
            var corpTeamList = GameHelper.GetSameCorpTeamList(order.GameId);
            if (corpTeamList.IsNotNullOrEmpty())
            {
                int count = order.PositionList.Count / 2;
                for (int i = 0; i < count; i++)
                {
                    var team1 = corpTeamList.FirstOrDefault(p => p.Id == order.PositionList[i * 2].UserId.GetId());
                    var team2 = corpTeamList.FirstOrDefault(p => p.Id == order.PositionList[i * 2 + 1].UserId.GetId());
                    if (team1 == null || team2 == null)
                    {
                        continue;
                    }
                    //相同单位队伍第一轮淘汰赛相遇，调整位置
                    if (team2.CompanyId == team1.CompanyId)
                    {
                        var pos1 = order.PositionList[i * 2];
                        var pos2 = order.PositionList[i * 2 + 1];
                        //交换低排名的相同单位队伍
                        var switchPos = pos1.Rank > pos2.Rank ? pos1 : pos2;
                        //查找相同本middle区域排名相同的非轮空队伍
                        var other = order.PositionList.FirstOrDefault(p => p.Index / order.Middle() == switchPos.Index / order.Middle() && p.Rank == switchPos.Rank && p.Index != switchPos.Index && !p.IsBye);
                        if (other != null)
                        {
                            //交换位置
                            var tempUserId = switchPos.UserId;
                            switchPos.UserId = other.UserId;
                            other.UserId = tempUserId;
                        }
                    }
                }
            }
        }

        private static void SetPositionListFirst(GameOrder order)
        {
            //获取抽签位置
            order.PositionList = new List<GamePosition>();
            for (int i = 0; i < order.KnockoutTotalAB; i++)
            {
                order.PositionList.Add(new GamePosition { Index = i });
            }
            //设置种子位置
            var seedList = KnockoutDrawHelper.CalRankPosAndSort(order.KnockoutTotalAB, order.KnockoutCountAB, 1);
            foreach (int index in seedList)
            {
                order.PositionList[index].Index = index;
                order.PositionList[index].IsSeed = true;
            }
        }

        /// <summary>
        /// 设置淘汰赛人员
        /// </summary>
        /// <param name="order"></param>
        /// <param name="isDefault"></param>
        public static void SetPositionListTwo(GameOrder order, bool isDefault)
        {
            //初始化所有位置
            order.PositionList = new List<GamePosition>();
            for (int i = 0; i < order.KnockoutTotalAB; i++)
            {
                order.PositionList.Add(new GamePosition { Index = i });
            }

            //获取1，2名位置列表
            var posList1 = KnockoutDrawHelper.CalRankPosAndSort(order.KnockoutTotalAB, order.KnockoutCountAB, 1);
            var posList2 = KnockoutDrawHelper.CalRankPosAndSort(order.KnockoutTotalAB, order.KnockoutCountAB, 2);

            //获取出线成员列表
            var memberList = SortGroupMember(order, isDefault, posList1);

            //添加前1，2名位置
            AttachOneAndTwo(order, posList1, posList2, memberList);

            //非AB模式前4名出线，附加3，4名位置
            if (!order.IsKnockOutAB && order.KnockoutCount == 4)
            {
                AttachThreeAndFour(order, memberList);
            }

            CheckByeOrKnock(order, posList1, memberList);
        }

        private static void CheckByeOrKnock(GameOrder order, List<int> posList1, List<GameGroupMember> memberList)
        {
            var count = Math.Abs(order.KnockoutTotalAB - order.ActualCount());
            if (count > 0)
            {
                if (order.KnockoutTotalAB > order.ActualCount())
                {
                    //设置轮空
                    for (int i = 0; i < count; i++)
                    {
                        var pos = posList1[i] % 2 == 0 ? posList1[i] + 1 : posList1[i] - 1;
                        //查找本middle区域非轮空的空位
                        var targetPos = order.PositionList.FirstOrDefault(p => p.Index / order.Middle() == pos / order.Middle() && p.UserId.IsNullOrEmpty() && !p.IsBye);
                        if (targetPos != null)
                        {
                            targetPos.UserId = order.PositionList[pos].UserId;
                            targetPos.GroupId = order.PositionList[pos].GroupId;
                            order.PositionList[pos].UserId = null;
                            order.PositionList[pos].GroupId = null;
                            order.PositionList[pos].IsBye = true;
                        }
                    }
                }
                else
                {
                    //抢号人员
                    var knockList = memberList.Where(p => p.IsEnterPos == false).ToList();
                    //设置抢号
                    for (int i = 0; i < count; i++)
                    {
                        var pos = posList1[i] % 2 == 0 ? posList1[i] + 1 : posList1[i] - 1;
                        order.PositionList[pos].KnockUserId = knockList[i].TeamId;
                    }
                }
            }
        }

        private static void AttachOneAndTwo(GameOrder order, List<int> posList1, List<int> posList2, List<GameGroupMember> memberList)
        {
            for (int i = 0; i < order.KnockoutTotalAB / order.KnockoutCountAB; i++)
            {
                order.PositionList[posList1[i]].UserId = memberList[i * order.KnockoutCountAB].TeamId;
                order.PositionList[posList1[i]].GroupId = memberList[i * order.KnockoutCountAB].GroupId;

                order.PositionList[posList1[i]].IsSeed = true;
                memberList[i * order.KnockoutCountAB].IsEnterPos = true;
            }

            for (int i = 0; i < order.KnockoutTotalAB / order.KnockoutCountAB; i++)
            {
                order.PositionList[posList2[i]].UserId = memberList[i * order.KnockoutCountAB + 1].TeamId;
                order.PositionList[posList2[i]].GroupId = memberList[i * order.KnockoutCountAB + 1].GroupId;

                memberList[i * order.KnockoutCountAB + 1].IsEnterPos = true;
            }
        }

        private static List<GameGroupMember> SortGroupMember(GameOrder order, bool isDefault, List<int> posList1)
        {
            var allMemberList = GetGroupKnockUserList(order, order.BeginRankAB, order.EndRankAB);
            var memberList = new List<GameGroupMember>();
            if (!isDefault)
            {
                //非默认，按抽签重新组织顺序
                foreach (var index in posList1)
                {
                    var pos = order.SeedList.FirstOrDefault(P => P.Index == index);
                    if (pos.UserId.IsNotNullOrEmpty())
                    {
                        foreach (var mem in allMemberList.Where(p => p.GroupId.GetId() == pos.GroupId.GetId()))
                        {
                            memberList.Add(mem);
                        }
                    }
                    else
                    {
                        //按小组补轮空位置
                        for (int i = 0; i < order.KnockoutCountAB; i++)
                        {
                            memberList.Add(new GameGroupMember { });
                        }
                    }
                }
                //尝试加入抢号人员
                if (allMemberList.Count > memberList.Count)
                {
                    foreach (var more in allMemberList)
                    {
                        if (!memberList.Contains(more))
                        {
                            memberList.Add(more);
                        }
                    }
                }
            }
            else
            {
                //默认，按小组顺序
                memberList = allMemberList;

                //补人数轮空位置
                var needPos = order.KnockoutTotalAB - order.ActualCount();
                if (needPos > 0)
                {
                    for (int i = 0; i < needPos; i++)
                    {
                        memberList.Add(new GameGroupMember { });
                    }
                }
            }
            return memberList;
        }

        private static void AttachThreeAndFour(GameOrder order, List<GameGroupMember> memberList)
        {
            var posList3 = KnockoutDrawHelper.CalRankPosAndSort(order.KnockoutTotalAB, order.KnockoutCountAB, 3);
            var posList4 = KnockoutDrawHelper.CalRankPosAndSort(order.KnockoutTotalAB, order.KnockoutCountAB, 4);
            for (int i = 0; i < order.KnockoutTotalAB / order.KnockoutCountAB; i++)
            {
                order.PositionList[posList3[i]].UserId = memberList[i * order.KnockoutCountAB + 2].TeamId;
                order.PositionList[posList3[i]].GroupId = memberList[i * order.KnockoutCountAB + 2].GroupId;

                memberList[i * order.KnockoutCountAB + 2].IsEnterPos = true;
            }

            for (int i = 0; i < order.KnockoutTotalAB / order.KnockoutCountAB; i++)
            {
                order.PositionList[posList4[i]].UserId = memberList[i * order.KnockoutCountAB + 3].TeamId;
                order.PositionList[posList4[i]].GroupId = memberList[i * order.KnockoutCountAB + 3].GroupId;

                memberList[i * order.KnockoutCountAB + 3].IsEnterPos = true;
            }
        }

        private static List<GameGroupMember> GetGroupKnockUserList(GameOrder currentOrder, int beginRank, int endRank)
        {
            var cmdMember = CommandHelper.CreateProcedure<GameGroupMember>(text: "sp_GetGameGroupRankList");
            cmdMember.Params.Add(CommandHelper.CreateParam("@gameId", currentOrder.GameId));
            cmdMember.Params.Add(CommandHelper.CreateParam("@beginRank", beginRank, DataType.Int32));
            cmdMember.Params.Add(CommandHelper.CreateParam("@endRank", endRank, DataType.Int32));
            var memberList = DbContext.GetInstance().Execute(cmdMember).Entities.ToList<EntityBase, GameGroupMember>();

            return memberList;
        }

    }
}
