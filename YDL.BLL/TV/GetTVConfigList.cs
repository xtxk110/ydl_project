using System;
using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Core;
using YDL.Utility;
using System.Collections.Generic;

namespace YDL.BLL
{
    public class GetTVConfigList : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetCoachRelatedFilter>>(request);
            var sql = @"
   SELECT * FROM dbo.TVConfig  ORDER BY CreateDate DESC
";
            var cmd = CommandHelper.CreateText<TVConfig>(FetchType.Fetch, sql);
            var result = DbContext.GetInstance().Execute(cmd);
            var resultList = result.Entities.ToList<EntityBase, TVConfig>();
            if (resultList.Count > 0)
            {
                List<TVConfig> tvConfigList = new List<TVConfig>();

                for (int i = 0; i < resultList.Count; i++)
                {
                    if (i == 0)
                    {
                        //第一次
                        TVConfig tvConfigFirst = new TVConfig();
                        tvConfigFirst.UserCode = resultList[0].UserCode;
                        var tvCodeList = resultList.Where(e => e.UserCode == resultList[0].UserCode).ToList();
                        foreach (var item in tvCodeList)
                        {
                            tvConfigFirst.TVCodeList.Add(item.TVCode);
                        }
                        tvConfigList.Add(tvConfigFirst);

                    }
                    //大于第一次
                    else if (resultList[i].UserCode == resultList[i - 1].UserCode)//和上一个相等
                    {
                        continue;
                    }
                    else if (resultList[i].UserCode != resultList[i - 1].UserCode)//和上一个不相等
                    {
                        TVConfig tvConfig = new TVConfig();
                        tvConfig.UserCode = resultList[i].UserCode;
                        var tvCodeList = resultList.Where(e => e.UserCode == resultList[i].UserCode).ToList();
                        foreach (var item in tvCodeList)
                        {
                            tvConfig.TVCodeList.Add(item.TVCode);
                        }
                        tvConfigList.Add(tvConfig);
                    }
                }

                result.Entities.Clear();
                result.Entities.AddRange(tvConfigList);
                return result;

            }

            return result;

        }


    }
}
