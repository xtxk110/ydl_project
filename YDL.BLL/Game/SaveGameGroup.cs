using System;
using System.Linq;
using System.Text;
using System.Collections.Generic;

using Newtonsoft.Json;
using YDL.Core;
using YDL.Map;
using YDL.Model;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 抽签完毕，保存抽签分组
    /// </summary>
    public class SaveGameGroup : IService
    {
        /// <summary>
        /// 抽签完毕，保存抽签分组
        /// </summary>
        /// <param name="currentUser">忽略</param>
        /// <param name="request">Request.GameGroup</param>
        /// <returns>Response.EmptyEntity</returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GameGroup>>(request);

            return Excute(req.Entities);
        }

        private static Response Excute(List<GameGroup> gplist)
        {
            if (gplist.IsNullOrEmpty())
            {
                return ResultHelper.Fail("无数据。");
            }
            //检查比赛状态，比赛准备才允许小组抽签
            var firstGroup = gplist.First();

            var game = GameHelper.GetGame(firstGroup.GameId);
            if (game.State != GameState.PREPARE.Id)
            {
                return ResultHelper.Fail("比赛准备才能进行小组抽签。");
            }

            bool isRoundThenKnock = game.KnockoutOption == KnockoutOption.ROUND_KNOCKOUT.Id;
            //先循环后淘汰，验证组成员
            if (isRoundThenKnock)
            {
                var firstOrder = GameHelper.GetGameOrder(firstGroup.OrderId);
                //根据OrderNo排序
                foreach (var group in gplist)
                {
                    //验证小组人数不足出线人数
                    if (group.MemberList.Count < firstOrder.KnockoutCountAB)
                    {
                        return ResultHelper.Fail(string.Format("{0}人数不足要求出线人数{1}个，无法保存。", group.Name, firstOrder.KnockoutCount));
                    }
                    group.MemberList = group.MemberList.OrderBy(p => p.OrderNo).ToList();
                }
            }

            var memberEntities = new List<EntityBase>();
            var loopEntities = new List<EntityBase>();
            foreach (var group in gplist)
            {
                if (group.MemberList.IsNotNullOrEmpty())
                {
                    //先循环后淘汰，创建组成员
                    if (isRoundThenKnock)
                    {
                        CreateOneGroupMembers(memberEntities, group);
                    }
                    //创建组循环赛
                    CreateOneGroupLoops(loopEntities, group);
                }
            }

            //合并数据
            var entities = new List<EntityBase>();

            //先循环后淘汰，保存组成员
            if (isRoundThenKnock && memberEntities.IsNotNullOrEmpty())
            {
                entities.AddRange(memberEntities);
            }
            if (loopEntities.IsNotNullOrEmpty())
            {
                entities.AddRange(loopEntities);
            }

            var cmdSave = CommandHelper.CreateSave(entities);

            //删除原来生成的小组赛轮次表，后面重新生成
            var cmdDelete = CommandHelper.CreateProcedure(FetchType.Execute, "sp_DeleteGameGroup");
            cmdDelete.Params.Add("@GameId", gplist.First().GameId);
            cmdDelete.Params.Add("@GroupIdString", GetGroupIdString(gplist));
            cmdSave.PreCommands.Add(cmdDelete);

            return DbContext.GetInstance().Execute(cmdSave);
        }

        private static string GetGroupIdString(List<GameGroup> gplist)
        {
            StringBuilder sb = new StringBuilder();
            foreach (var group in gplist)
            {
                if (sb.Length > 0)
                {
                    sb.Append(Constant.Str_Comma);
                }
                sb.Append(group.Id);
            }
            return sb.ToString();
        }

        public static void CreateOneGroupMembers(List<EntityBase> memberEntities, GameGroup group)
        {
            group.MemberList.ForEach(p =>
            {
                p.SetRowAdded();
                p.TeamId = p.TeamId.GetId();
                p.SetNewId();
                p.SetCreateDate();
                memberEntities.Add(p);
            });//数据保存
        }

        public static void CreateOneGroupLoops(List<EntityBase> loopEntities, GameGroup group)
        {
            CheckMemberEvennumber(group);
            int memberCount = group.MemberList.Count;
            //逆时针轮转法
            for (int i = 1; i < memberCount; i++)
            {
                foreach (var member in group.MemberList)
                {
                    int index = group.MemberList.IndexOf(member);
                    if (index + 1 > memberCount / 2)
                    {
                        break;
                    }

                    var loop = CreateLoopGame(group, i, member, index, memberCount - 1 - index);
                    //排除轮空比赛
                    if (loop != null)
                    {
                        loop.LoopOrderNo = index + 1;
                        loopEntities.Add(loop);//数据保存
                    }
                }
                //轮转位置
                var last = group.MemberList[memberCount - 1];
                group.MemberList.Remove(last);
                group.MemberList.Insert(1, last);
            }
        }

        private static void CheckMemberEvennumber(GameGroup group)
        {
            if (group.MemberList.Count % 2 != 0)
            {
                var emptyMember = new GameGroupMember { TeamId = string.Empty, GameId = group.GameId, GroupId = group.Id, IsTeam = group.IsTeam };
                group.MemberList.Add(emptyMember);
            }
        }

        private static GameLoop CreateLoopGame(GameGroup group, int i, GameGroupMember member, int index, int indexOther)
        {
            var team1Id = group.MemberList[index].TeamId;
            var team2Id = group.MemberList[indexOther].TeamId;
            //排除轮空比赛
            if (team1Id.IsNullOrEmpty() || team2Id.IsNullOrEmpty())
            {
                return null;
            }
            GameLoop loop = new GameLoop();
            loop.SetNewId();
            loop.SetCreateDate();
            loop.SetRowAdded();

            loop.OrderNo = i;//分组小轮次
            loop.OrderId = group.OrderId;
            loop.GameId = member.GameId;
            loop.GroupId = member.GroupId;
            loop.Team1Id = team1Id;
            loop.Team2Id = team2Id;
            loop.IsTeam = member.IsTeam;
            loop.State = GameLoopState.NOTSTART.Id;
            loop.IsBye = group.MemberList[index].TeamId.IsNullOrEmpty() || group.MemberList[indexOther].TeamId.IsNullOrEmpty();
            loop.JudgeId = group.LeaderId.GetId();
            return loop;
        }
    }
}
