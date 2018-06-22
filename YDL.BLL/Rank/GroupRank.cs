using System.Collections.Generic;
using System.Linq;
using System;

using YDL.Core;
using YDL.Map;
using YDL.Model;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 计算一个小组成员排名(已完成场次比赛)
    /// </summary>
    public class GroupRank
    {
        private List<GameGroupMember> players;
        private List<GameLoop> scores;
        private bool isTeam;

        /// <summary>
        /// 计算排名
        /// </summary>
        /// <param name="players">某个小组成员列表</param>
        /// <param name="scores">已完成场次比分列表</param>
        public string Rank(string groupId)
        {
            //验证是否存在未结束的比赛，排除轮空场次
            if (!ValidateFinish(groupId))
                return "小组存在未结束的比赛场次，不能计算排名。";

            //比赛全部结束，则计算排名，排除轮空场次
            GetGroupMembers(groupId);
            GetGroupLoops(groupId);

            if (players.IsNotNullOrEmpty() && scores.IsNotNullOrEmpty())
            {
                this.isTeam = players.First().IsTeam;

                //初始化数据
                Init(players);

                //计算
                Calculate(players.Select(p => p.TeamId).ToList(), new CalScore());

                //设置排名
                SetRank(players);

                //保存排名数据
                players.ForEach(p => p.SetRowModified());
                DbContext.GetInstance().Execute(CommandHelper.CreateSave(players));
            }
            return null;
        }

        private static bool ValidateFinish(string groupId)
        {
            var cmdVal = CommandHelper.CreateText(FetchType.Scalar, "SELECT COUNT(*) FROM GameLoop WHERE GroupId=@GroupId AND State!='011003' AND IsBye=0 AND IsExtra=0");
            cmdVal.Params.Add(CommandHelper.CreateParam("@GroupId", groupId));
            var result = DbContext.GetInstance().Execute(cmdVal);
            return (int)result.Tag == 0;
        }

        private void GetGroupLoops(string groupId)
        {
            var cmdLoop = CommandHelper.CreateText<GameLoop>(text: "SELECT * FROM GameLoop WHERE GroupId=@GroupId AND IsBye=0 AND IsExtra=0");
            cmdLoop.Params.Add(CommandHelper.CreateParam("@GroupId", groupId));
            scores = DbContext.GetInstance().Execute(cmdLoop).Entities.ToList<EntityBase, GameLoop>();
        }

        private void GetGroupMembers(string groupId)
        {
            var cmd = CommandHelper.CreateText<GameGroupMember>(text: "SELECT * FROM GameGroupMember WHERE GroupId=@GroupId");
            cmd.Params.Add(CommandHelper.CreateParam("@GroupId", groupId));
            players = DbContext.GetInstance().Execute(cmd).Entities.ToList<EntityBase, GameGroupMember>();
        }

        private static void SetRank(List<GameGroupMember> players)
        {
            foreach (var obj in players)
            {
                obj.TotalOrder += 1;
                obj.Rank = obj.TotalOrder;
            }
        }

        private static void Init(List<GameGroupMember> players)
        {
            foreach (var obj in players)
            {
                //临时字段
                obj.Score = 0;
                obj.WinScore = 0;
                obj.LoseScore = 0;
                obj.Order = 0;
                obj.TotalOrder = 0;
                obj.SameCount = 0;
                //持久字段
                obj.Rank = 0;
                obj.Rate = 0;
                obj.RateRemark = string.Empty;
                obj.GroupScore = 0;
            }
        }

        private void Calculate(List<string> samePlayers, CalBase cal)
        {
            var groupPlayers = players.Where(p => samePlayers.Contains(p.TeamId)).ToList();
            foreach (var obj in groupPlayers)
            {
                cal.Cal(obj, samePlayers, scores);
                //记录第一次积分结果，展示给用户
                if (obj.GroupScore == 0)
                    obj.GroupScore = (int)obj.Score;
                else if (!(cal is CalScore))//非积分比较，记录每一次比率
                {
                    if (obj.RateRemark.IsNotNullOrEmpty())
                        obj.RateRemark = obj.RateRemark + "/" + Convert.ToString(obj.Score);
                    else
                        obj.RateRemark = Convert.ToString(obj.Score);
                }
            }

            var sameGroups = new Dictionary<double, List<string>>();
            foreach (var obj in groupPlayers)
            {
                obj.Order = groupPlayers.Count(p => p.Score > obj.Score);
                obj.SameCount = groupPlayers.Count(p => p.Score == obj.Score);
                obj.TotalOrder += obj.Order;

                if (obj.SameCount > 1)//本次存在分数相同的情况
                    if (sameGroups.ContainsKey(obj.Score))
                        sameGroups[obj.Score].Add(obj.TeamId);
                    else
                        sameGroups.Add(obj.Score, new List<string> { obj.TeamId });
            }

            if (sameGroups.IsNotNullOrEmpty())//存在分数相同分组
            {
                bool isOnlyOneGroup = sameGroups.First().Value.Count == groupPlayers.Count;
                if (isOnlyOneGroup)//当前只存在一个分组，本次比分模式所有人相等，则继续比较
                {
                    var nextCal = cal.NextCal(isTeam);
                    if (nextCal != null)
                        Calculate(samePlayers, nextCal);
                    else
                        groupPlayers.ForEach(p => { p.Remark = "抽签确定名次"; });//最终还是存在多个相同名次，则设置提示
                }
                else
                    foreach (var obj in sameGroups)
                        Calculate(obj.Value, new CalScore());//存在多个分组，则从头开始比较每组人员
            }
        }

    }
}
