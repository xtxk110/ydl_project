using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Map;
using YDL.Model;

namespace YDL.BLL
{
    public class LimitHelper
    {
        /// <summary>
        /// 判断此角色是否被此用户拥有
        /// </summary>
        /// <param name="userid"></param>
        /// <param name="roleid"></param>
        /// <returns></returns>
       public static bool IsChecked(string userid, string roleid)
        {
            bool flag = false;
            string sqlStr = @"SELECT * FROM LimitRoleUserMap WHERE UserId=@userid AND RoleId=@roleid";
            var cmd1 = CommandHelper.CreateText<LimitRoleUserMap>(FetchType.Fetch, sqlStr);
            cmd1.Params.Add("@userid", userid);
            cmd1.Params.Add("@roleid", roleid);
            var result = DbContext.GetInstance().Execute(cmd1).Entities;
            if (result != null && result.Count > 0)
                flag = true;
            return flag;
        }
        /// <summary>
        /// 剔除相应的在线用户
        /// </summary>
        /// <param name="userid"></param>
        /// <returns></returns>
        public static bool DeleteOnlieUser(string userid)
        {
            bool flag = false;
            string delSql = @"DELETE FROM OnlineUser WHERE UserId=@userid";
            var cmd = CommandHelper.CreateText(FetchType.Execute, delSql);
            cmd.Params.Add("@userid", userid);
            var result = DbContext.GetInstance().Execute(cmd);
            if (result.IsSuccess)
                flag = true;

            return flag;
        }
        /// <summary>
        /// 根据权限合,解析出相应权限集合
        /// </summary>
        /// <param name="rang">权限合</param>
        /// <param name="list"></param>
        /// <returns></returns>
        public static void GetLimitRangeList(int rang,HashSet<int> list)
        {
            if (rang == 0)
                return;
            int count = 0;
            while (true)
            {
                if ((int)Math.Pow(2, count) == rang)
                {
                    list.Add(rang);
                    break;
                }
                else if (Math.Pow(2, count) > rang)
                {
                    int limit = (int)Math.Pow(2, count - 1);
                    list.Add(limit);
                    int temRange = rang - limit;
                    GetLimitRangeList(temRange,list);
                    break;
                }
                else
                    count++;
            }
        }
        /// <summary>
        /// 获取某个用户的权限值集合、业务类型字典
        /// </summary>
        /// <param name="userid">用户ID</param>
        /// <param name="limitBussinessType">权限业务类型</param>
        /// <returns></returns>
        public static Dictionary<string, HashSet<int>> GetLimitByUser(string userid,string limitBussinessType="")
        {
            Dictionary<string, HashSet<int>> dic = new Dictionary<string, HashSet<int>>();

            string sqlStr = @"SELECT a.LimitName,a.LimitDetail FROM Limit AS a INNER JOIN LimitRoleUserMap AS b ON a.RoleId=b.RoleId WHERE b.UserId=@userid AND a.LimitDetail !=0";
            if (!string.IsNullOrEmpty(limitBussinessType))
                sqlStr = sqlStr + @" AND a.LimitName=@limitType";
            var cmd = CommandHelper.CreateText<Limit>(FetchType.Fetch, sqlStr);
            cmd.Params.Add("@userid", userid);
            if (!string.IsNullOrEmpty(limitBussinessType))
                cmd.Params.Add("@limitType", limitBussinessType);
            var res = DbContext.GetInstance().Execute(cmd);
            
            if (res.Entities != null && res.Entities.Count > 0)
            {
                foreach(Limit item in res.Entities)
                {
                    if (dic.ContainsKey(item.LimitName))
                    {
                        GetLimitRangeList(item.LimitDetail, dic[item.LimitName]);
                    }
                    else
                    {
                        HashSet<int> hashSet = new HashSet<int>();
                        GetLimitRangeList(item.LimitDetail, hashSet);
                        dic.Add(item.LimitName, hashSet);
                    }
                }
            }
            return dic;
        }
        /// <summary>
        /// 获取权限分类的具体操作权限
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public static List<LimitDetail> GetLimitDetailList(LimitBaseData entity)
        {
            List<LimitDetail> detailList = new List<LimitDetail>();
            HashSet<int> rangeSet = new HashSet<int>();
            GetLimitRangeList(entity.Range, rangeSet);
            foreach(int item in rangeSet)
            {
                LimitDetail detail = new LimitDetail { Id = ((OperationRightType)item).ToString(), Name = ((OperationRightType)item).GetEnumDescription(), Range = item };
                detailList.Add(detail);
            }
            return detailList;
        }
        /// <summary>
        /// 获取某个角色的所有用户
        /// </summary>
        /// <param name="roleid"></param>
        /// <returns></returns>
        public static List<LimitRoleUserMap> GetRoleUserMap(string roleid)
        {
            List<LimitRoleUserMap> list = new List<LimitRoleUserMap>();
            string sqlStr = @"SELECT * FROM LimitRoleUserMap WHERE RoleId=@roleid";
            var cmd = CommandHelper.CreateText<LimitRoleUserMap>(FetchType.Fetch, sqlStr);
            cmd.Params.Add("@roleid", roleid);
            var res = DbContext.GetInstance().Execute(cmd);
            if (res.Entities.Count > 0)
            {
                foreach(var item in res.Entities)
                {
                    list.Add(item as LimitRoleUserMap);
                }
            }

            return list;
        }
    }
}
