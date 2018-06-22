using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;
using YDL.Core;
using YDL.Map;
using YDL.Model;
using YDL.Utility;
using System.Text.RegularExpressions;

namespace YDL.BLL
{
    /// <summary>
    /// 团体对阵模板相关工具类
    /// </summary>
    public class GameLoopTempletHelper
    {
        /// <summary>
        /// 获取对阵列表模板
        /// </summary>
        /// <param name="userid">当前登录者用户ID</param>
        /// <param name="name">模板名称</param>
        /// <param name="action">操作类型(默认1):1,创建赛事时获取;2,我的模板页面时获取</param>
        /// <returns></returns>
        public static Response GetTempletList(string userid,string name,int action=1)
        {
            string sqlStr = @"SELECT *  FROM GameTeamLoopTemplet WHERE Name LIKE '%" + name + "%' " +
                           " AND IsEnable=1 AND ((IsDefault=1 AND CreatorId!=@userid ) OR (CreatorId=@userid ) OR (IsShared=1 AND CreatorId !=@userid AND IsDefault !=1)) ORDER BY IsDefault DESC,CASE WHEN CreatorId=@userid THEN 1 ELSE 0 END DESC,IsShared";
            List<DbParam> param = new List<DbParam>();
            //param.Add("@name", name);
            if (action == 2)//进入我的模板页面时调用
            {
                sqlStr = @"SELECT *  FROM GameTeamLoopTemplet WHERE Name LIKE '%"+name+"%' "+
                           "AND ((IsDefault=1 AND CreatorId!=@userid AND IsEnable=1) OR (CreatorId=@userid) OR (IsShared=1 AND CreatorId !=@userid AND IsDefault !=1 AND IsEnable=1)) ORDER BY IsDefault DESC,CASE WHEN CreatorId=@userid THEN 1 ELSE 0 END DESC,IsShared";
                //param.Add("@userid", userid);
            }
            param.Add("@userid", userid);
            Command cmd = CommandHelper.CreateText<GameTeamLoopTemplet>(FetchType.Fetch, sqlStr);
            cmd.Params.AddRange(param);
            Response res = DbContext.GetInstance().Execute(cmd);
            return res;
        }
        /// <summary>
        /// 检查团体对阵模板是否重名(修改模板时,不检查)
        /// </summary>
        /// <param name="name"></param>
        /// <param name="modifyFlag">修改时,传true;新建时传false</param>
        /// <returns></returns>
        public static bool IsExistTemplet(string name,bool modifyFlag)
        {
            if (modifyFlag)
                return false;
            bool result = false;
            string sqlStr = @"SELECT * FROM GameTeamLoopTemplet WHERE  Name = @name";
            Command cmd = CommandHelper.CreateText<GameTeamLoopTemplet>(FetchType.Fetch, sqlStr);
            cmd.Params.Add("@name",name);
            Response res = DbContext.GetInstance().Execute(cmd);
            if (res.Entities.Count>0)
                result = true;

            return result;
        }
        /// <summary>
        /// 此对阵模板是否被赛事使用过
        /// </summary>
        /// <param name="templetId">对阵模板ID</param>
        /// <returns></returns>
        public static bool IsUseTemplet(string templetId)
        {
            bool flag = false;
            string sqlStr = @"SELECT Id FROM Game WHERE State!='015009' AND TeamMode=@templetId";
            Command cmd = CommandHelper.CreateText<Game>(FetchType.Fetch, sqlStr);
            cmd.Params.Add("@templetId", templetId);
            Response result = DbContext.GetInstance().Execute(cmd);
            if (result.Entities.Count > 0)
                flag = true;

            return flag;
        }
        /// <summary>
        /// 获取某个对阵模板
        /// </summary>
        /// <param name="templetId"></param>
        /// <returns></returns>
        public static GameTeamLoopTemplet GetTemplet(string templetId)
        {
            GameTeamLoopTemplet templet = null;
            string sqlStr = @"SELECT * FROM GameTeamLoopTemplet WHERE Id=@templetId";
            Command cmd = CommandHelper.CreateText<GameTeamLoopTemplet>(FetchType.Fetch, sqlStr);
            cmd.Params.Add("@templetId", templetId);
            Response result = DbContext.GetInstance().Execute(cmd);
            if (result.Entities.Count > 0)
                templet = result.Entities[0] as GameTeamLoopTemplet;
            return templet;
        }
        /// <summary>
        /// 通过名称获取模板
        /// </summary>
        /// <param name="templetName"></param>
        /// <returns></returns>
        public static List<EntityBase> GetTemplets(string templetName)
        {
            string sqlStr = @"SELECT * FROM GameTeamLoopTemplet WHERE  Name = @name";
            Command cmd = CommandHelper.CreateText<GameTeamLoopTemplet>(FetchType.Fetch, sqlStr);
            cmd.Params.Add("@name", templetName);
            Response res = DbContext.GetInstance().Execute(cmd);
            return res.Entities;
        }
        /// <summary>
        /// 设置模板分享状态
        /// </summary>
        /// <param name="templet"></param>
        /// <param name="current"></param>
        public static Response SetTempletState(GameTeamLoopTemplet templet,User current)
        {
            string sqlStr = @"UPDATE GameTeamLoopTemplet SET IsShared=@isShared,SharePersonId=@shareId WHERE Id=@templetId";
            Command cmd = CommandHelper.CreateText<GameTeamLoopTemplet>(FetchType.Execute, sqlStr);
            cmd.Params.Add("@templetId", templet.Id);
            cmd.Params.Add("@isShared", templet.IsShared);
            if (templet.IsShared)
                cmd.Params.Add("@shareId", current.Id);
            else
                cmd.Params.Add("@shareId", null);
            return DbContext.GetInstance().Execute(cmd);
        }
        /// <summary>
        /// 获取某个团体对阵模板及规则详情
        /// </summary>
        /// <param name="filter"></param>
        /// <returns></returns>
        public static Response GetTempletDetail(GameTeamLoopTempletFilter filter)
        {
            string sqlStr = @"SELECT a.*,CASE WHEN ISNULL(b.PetName, '')='' THEN b.CardName ELSE b.PetName END AS SharePerson,
                             CAST(CASE WHEN a.UseCount >=5 THEN 1 ELSE 0 END AS BIT) AS IsEnableShare 
                             FROM GameTeamLoopTemplet AS a LEFT JOIN UserAccount AS b ON a.SharePersonId=b.Id
                             WHERE a.Id=@templetId";
            Command cmd = CommandHelper.CreateText<GameTeamLoopTemplet>(FetchType.Fetch, sqlStr);
            cmd.Params.Add("@templetId", filter.TempletId);
            Response res = DbContext.GetInstance().Execute(cmd);
            if (res.Entities.Count > 0)
            {
                var temp = res.Entities[0] as GameTeamLoopTemplet;
                if (temp.UseCount > 0) {
                    temp.UseDes = "已被" + temp.UseCount + "场比赛使用";

                } else
                {
                    temp.UseDes = "还未正式被比赛使用过";
                    
                }
                temp.IsUse = GameLoopTempletHelper.IsUseTemplet(filter.TempletId);//模板是否使用
                sqlStr = @"SELECT * FROM GameTeamLoopTempletDetail WHERE TempletId=@templetId ORDER BY OrderNo ";
                if (!string.IsNullOrEmpty(filter.GameId) && !string.IsNullOrEmpty(filter.LoopId))//进入团体对阵页面时,获取规则对员对阵详情
                {
                    sqlStr = @"SELECT a.*,b.User1Name,b.User1Id,b.User2Name,b.User2Id FROM GameTeamLoopTempletDetail AS a LEFT JOIN GameLoopMap AS b ON a.OrderNo=b.OrderNo AND b.LoopId=@loopId
                               WHERE a.TempletId=@templetId ORDER BY a.OrderNo";
                }
                cmd = CommandHelper.CreateText<GameTeamLoopTempletDetail>(FetchType.Fetch, sqlStr);
                cmd.Params.Add("@templetId", filter.TempletId);
                if (!string.IsNullOrEmpty(filter.GameId) && !string.IsNullOrEmpty(filter.LoopId))
                    cmd.Params.Add("@loopId", filter.LoopId);
                Response res1 = DbContext.GetInstance().Execute(cmd);
                temp.Detail = res1.Entities.ToList<EntityBase, GameTeamLoopTempletDetail>();
                if (!string.IsNullOrEmpty(filter.GameId) && !string.IsNullOrEmpty(filter.LoopId))//进入团体对阵页面时,获取规则编码与队员映射关系
                {
                    sqlStr = @"SELECT a.Id,a.TempletId,a.GameId,a.LoopId,a.TeamId,a.Code,a.CodeUserId,a.CodeUserName,a.CreateDate,b.TeamName  
                              FROM GameTeamLoopTempletMap as a LEFT JOIN GameTeam as b ON a.TeamId=b.Id 
                              WHERE a.TempletId=@templetId AND a.GameId=@gameId AND a.LoopId=@loopId ORDER BY TeamId,a.Code";
                    cmd = CommandHelper.CreateText<GameTeamLoopTempletMap>(FetchType.Fetch, sqlStr);
                    cmd.Params.Add("@templetId", filter.TempletId);
                    cmd.Params.Add("@gameId", filter.GameId);
                    cmd.Params.Add("@loopId", filter.LoopId);
                    res1 = DbContext.GetInstance().Execute(cmd);
                    temp.Map = res1.Entities.ToList<EntityBase, GameTeamLoopTempletMap>();//规则编码与队员映射关系
                    temp.Team1Codes = GameLoopTempletHelper.GetRuleCodes(temp.PersonCount, true, false);
                    if(temp.IsGuest)
                        temp.Team2Codes = GameLoopTempletHelper.GetRuleCodes(temp.PersonCount,false, false);
                    else
                        temp.Team2Codes = GameLoopTempletHelper.GetRuleCodes(temp.PersonCount, true, false);
                }
            }
            return res;
        }
        /// <summary>
        /// 根据上场人数返回编码数据
        /// </summary>
        /// <param name="personCount">上场人数</param>
        /// <param name="flag">true生成队伍1编码;false生成队伍2编码</param>
        /// <param name="isStar">true数组后加*;false数组后不加*</param>
        /// <returns></returns>
        public static List<string> GetRuleCodes(int personCount, bool flag, bool isStar)
        {
            List<string> list = new List<string>();
            string codes = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
            if (flag)//队伍1编码
            {
                for (int i = 0; i < personCount; i++)
                {
                    list.Add(codes[i].ToString());
                }
            }
            else//队伍2编码
            {
                for (int i = codes.Length - personCount; i < codes.Length; i++)
                {
                    list.Add(codes[i].ToString());
                }
            }
            if (isStar)
                list.Add("*");
            return list;
        }
        /// <summary>
        /// 每使用一次赛事,模板使用数加1,赛事更改对阵模板时,原来的减1
        /// </summary>
        /// <param name="newTempletId">新对阵模板ID</param>
        /// <param name="oldTempletId">旧对阵模板ID</param>
        public static void UpdateTempletUseCount(string newTempletId,string oldTempletId)
        {
            string updateSql = "UPDATE GameTeamLoopTemplet SET UseCount=UseCount+1 WHERE Id=@templetId";
            var cmd = CommandHelper.CreateText<GameTeamLoopTemplet>(FetchType.Execute, updateSql);
            cmd.Params.Add("@templetId", newTempletId);
            if(!string.IsNullOrEmpty(oldTempletId))
            {
                var cmd2 = CommandHelper.CreateText<GameTeamLoopTemplet>(FetchType.Execute, "UPDATE GameTeamLoopTemplet SET UseCount=CASE WHEN UseCount-1<=0 THEN 0 ELSE UseCount-1 END WHERE Id=@templetId");
                cmd2.Params.Add("@templetId", oldTempletId);
                cmd.AfterCommands = new List<Command> { cmd2 };
            }
            var res = DbContext.GetInstance().Execute(cmd);
        }
        /// <summary>
        /// 某个队伍是否能参加这个团体比赛,根据队伍人数和模板上场人数比较
        /// </summary>
        /// <param name="gameId"></param>
        /// <param name="teamUserId"></param>
        /// <returns></returns>
        public static bool IsJoinGame(string gameId,string teamUserId)
        {
            bool result = false;
            int personCount = 0;
            int teamCount = 0;
            string sql1 = "SELECT b.PersonCount FROM Game AS a INNER JOIN GameTeamLoopTemplet AS b ON a.TeamMode=b.Id WHERE a.Id=@gameId";
            var cmd = CommandHelper.CreateText<GameTeamLoopTemplet>(FetchType.Fetch, sql1);
            cmd.Params.Add("@gameId", gameId);
            var res = DbContext.GetInstance().Execute(cmd);
            if (res.Entities.Count <= 0)
                return true;
            else
            {
                personCount = (res.Entities[0] as GameTeamLoopTemplet).PersonCount;
                res = null;
            }
            teamUserId = teamUserId.Trim(',');
            if (teamUserId.Contains(","))
            {
                teamCount = teamUserId.Count((item) => item == ',')+1;
            }
            else
                teamCount = 1;
            if (personCount <= teamCount)
                result = true;

            return result;
        }
        /// <summary>
        /// 修改正在使用的模板,则新增,按规则返回新的名称
        /// </summary>
        /// <param name="oldName"></param>
        /// <returns></returns>
        public static string GetNewTempletName(string oldName)
        {
            string newName = string.Empty;
            string pattern = @"\(\d\)$";
            if (Regex.IsMatch(oldName, pattern))
            {
                oldName=oldName.TrimEnd(Regex.Match(oldName, pattern).Value.ToArray());
            }
            Command cmd = CommandHelper.CreateText<GameTeamLoopTemplet>(FetchType.Fetch, @"SELECT Name FROM GameTeamLoopTemplet WHERE Name LIKE '" + oldName + "%'");
            var res = DbContext.GetInstance().Execute(cmd);
            for(int i = 1; i <= 100; i++)
            {
                newName = oldName + "(" + i + ")";
                int tempCount = 0;
                foreach(GameTeamLoopTemplet item in res.Entities)
                {
                    if (item.Name == newName)
                        tempCount++;
                }
                if (tempCount == 0)
                    break;
            }
            return newName;
        }
        /// <summary>
        /// 通过用户ID,获该用户创建的模板数量
        /// </summary>
        /// <param name="userId"></param>
        /// <returns></returns>
        public static int GetCountByUser(string userId)
        {
            string sqlStr = @"SELECT Id FROM GameTeamLoopTemplet WHERE  CreatorId = @userId";
            Command cmd = CommandHelper.CreateText<GameTeamLoopTemplet>(FetchType.Fetch, sqlStr);
            cmd.Params.Add("@userId", userId);
            Response res = DbContext.GetInstance().Execute(cmd);
            return res.Entities.Count;
        }
        /// <summary>
        /// 检查编码对应人员是否重复
        /// </summary>
        /// <param name="templetList">List<GameTeamLoopTempletMap></param>
        /// <returns></returns>
        public static bool IsSame(List<GameTeamLoopTempletMap> templetList)
        {
            bool flag = false;
            for(int i = 0; i < templetList.Count; i++)
            {
                if (i == templetList.Count - 1)
                    break;
                string temp1 = templetList[i].CodeUserId;
                for(int j = i + 1; j < templetList.Count; j++)
                {
                    string temp2= templetList[j].CodeUserId;
                    if (temp1 == temp2)
                        return true;
                }
            }

            return flag;
        }
    }
}
