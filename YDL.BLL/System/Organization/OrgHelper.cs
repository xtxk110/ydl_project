using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Model;
using YDL.Map;

namespace YDL.BLL
{
    public class OrgHelper
    {
        /// <summary>
        /// 获取机构的层级
        /// </summary>
        /// <param name="typeid"></param>
        /// <returns></returns>
        public static int GetOrgLevel(string typeid)
        {
            int level = 0;
            if (!string.IsNullOrEmpty(typeid))
            {
                level = typeid.Length / 5;
            }
            return level;
        }
        /// <summary>
        /// 获取机构模型
        /// </summary>
        /// <param name="typeid"></param>
        /// <returns></returns>
        public static Organization GetOrg(string typeid)
        {
            string sqlStr = @" SELECT* FROM Organization WHERE TypeId = @typeid";
            var cmd = CommandHelper.CreateText<Organization>(text: sqlStr);
            cmd.Params.Add("@typeid", typeid);
            var result = DbContext.GetInstance().Execute(cmd);
            return result.Entities.FirstOrDefault() as Organization;
        }
        /// <summary>
        /// 获取对应typeid的计数器
        /// </summary>
        /// <param name="typeid"></param>
        /// <returns></returns>
        public static int GetSonCounter(string typeid)
        {
            int counter = 0;
            var org = GetOrg(typeid);
            if (org != null)
                counter = org.SonCounter;
            return counter;
        }
        /// <summary>
        /// 生成新的TypeId
        /// </summary>
        /// <param name="parentTypeid"></param>
        /// <param name="counter"></param>
        /// <returns></returns>
        public static string GetNewOrgTypeid(string parentTypeid,int counter)
        {
            StringBuilder typeid = new StringBuilder(parentTypeid);
            counter += 1;
            typeid.Append(GetPartTypeId(counter.ToString()));

            return typeid.ToString();
        }
        /// <summary>
        /// 根据计数器返回部分typeid
        /// </summary>
        /// <param name="tempCounter"></param>
        /// <returns></returns>
        private static string GetPartTypeId(string tempCounter)
        {
            StringBuilder result = new StringBuilder();
            for(int i = 0; i < 5 - tempCounter.Length; i++)
            {
                result.Append("0");
            }
            result.Append(tempCounter);
            return result.ToString() ;
        }
    }
}
