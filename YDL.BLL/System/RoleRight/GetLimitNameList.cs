using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Map;
using YDL.Model;
using YDL.Core;

namespace YDL.BLL
{
    /// <summary>
    /// 获取总的业务分类权限
    /// </summary>
    class GetLimitNameList_196 : IService
    {
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<LimitModelFilter>>(request);
            var obj = req.Filter;
            List<LimitBaseData> list = LimitName.LimitList;
            Response res = ResultHelper.Success();
            //foreach (var item in list)
            //{
            //    if (item.Type == obj.Type)
            //    {
            //        res.Entities.Add(item);
            //    }
            //}
            //var ownLimit = GetOwnLimit(obj.RoleId, obj.Type);
            //if (ownLimit != null && ownLimit.Count > 0)
            //{
            //    List<LimitBaseData> OwnLimitList = new List<LimitBaseData>();
            //    foreach (var item in ownLimit)
            //    {
            //        LimitBaseData data = new LimitBaseData { Range = (item as Limit).LimitDetail, NameId = (item as Limit).LimitName };
            //        OwnLimitList.Add(data);
            //    }
            //    res.Tag = OwnLimitList;
            //}

            //获取所有列表
            foreach(var item in list)
            {
                if (item.Type == obj.Type)
                {
                    res.Entities.Add(item);
                }
            }
            var ownLimitList = GetOwnLimit(obj.RoleId, obj.Type);//获取拥有的权限列表

            foreach (var item in res.Entities)
            {
                if ((item as LimitBaseData).Type != 1)//针对权限值只有0或1的情况
                {
                    (item as LimitBaseData).IsSelected = false;
                    (item as LimitBaseData).Range = 0;
                }
                (item as LimitBaseData).DetailLimit= LimitHelper.GetLimitDetailList(item as LimitBaseData);
                foreach (var item1 in ownLimitList)
                {
                    if((item as LimitBaseData).NameId== (item1 as Limit).LimitName)
                    {
                        if ((item as LimitBaseData).Type != 1)//针对权限值只有0或1的情况
                        {
                            (item as LimitBaseData).Range = (item1 as Limit).LimitDetail;
                            if ((item1 as Limit).LimitDetail == 1)
                                (item as LimitBaseData).IsSelected = true;
                            else
                                (item as LimitBaseData).IsSelected = false;
                        }

                        HashSet<int> rangeSet = new HashSet<int>();
                        LimitHelper.GetLimitRangeList((item1 as Limit).LimitDetail, rangeSet);

                        foreach (int k in rangeSet)
                        {
                            
                            (item as LimitBaseData).DetailLimit.AsParallel().ForAll((j) =>
                            {
                                if (j.Range == k)
                                    j.IsSelected = true;
                            });
                            
                        }
                    }
                    
                }
            }

            return res;
        }
        /// <summary>
        /// 根据角色和当前业务获取已经所有的权限
        /// </summary>
        /// <param name="roleid"></param>
        /// <param name="type"></param>
        private List<EntityBase> GetOwnLimit(string roleid,int type)
        {
            string sqlStr = @"SELECT * FROM Limit WHERE RoleId=@roleid AND Type=@type ";
            var cmd = CommandHelper.CreateText<Limit>(FetchType.Fetch, sqlStr);
            cmd.Params.Add("@roleid", roleid);
            cmd.Params.Add("@type", type);
            var response = DbContext.GetInstance().Execute(cmd);
            return response.Entities;
        }
    }
}
