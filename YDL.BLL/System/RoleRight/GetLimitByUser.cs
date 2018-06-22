using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Core;
using YDL.Map;
using YDL.Model;

namespace YDL.BLL
{
    /// <summary>
    /// 根据用户获取相应权限
    /// </summary>
    class GetLimitByUser_196 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<LimitFilter>>(request);
            var obj = req.Filter;
            Dictionary<string, HashSet<int>> dic = LimitHelper.GetLimitByUser(currentUser.Id, obj.LimitName);
            Response res = ResultHelper.CreateResponse();
            foreach(var item in dic)
            {
                Limit limit = new Limit();
                int rang = 0;
                foreach(int k in item.Value)
                {
                    rang += k;
                }
                limit.LimitName = item.Key;
                limit.LimitDetail = rang;
                res.Entities.Add(limit);
            }
            return res;
        }
        /// <summary>
        /// 获取用户权限
        /// </summary>
        /// <param name="userid"></param>
        /// <returns></returns>
        public static List<Limit> GetLimitList(string userid)
        {
            List<Limit> list = new List<Limit>();
            Dictionary<string, HashSet<int>> dic = LimitHelper.GetLimitByUser(userid);
            foreach (var item in dic)
            {
                Limit limit = new Limit();
                int rang = 0;
                foreach (int k in item.Value)
                {
                    rang += k;
                }
                limit.LimitName = item.Key;
                limit.LimitDetail = rang;
                list.Add(limit);
            }
            return list;
        }
    }
}
