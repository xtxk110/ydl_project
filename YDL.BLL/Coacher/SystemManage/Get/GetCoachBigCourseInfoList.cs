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
    /// <summary>
    /// 获取大课介绍信息列表
    /// </summary>
    public class GetCoachBigCourseInfoList_186 : IService
    {
        public Response Execute(string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetSystemManageRelatedFilter>>(request);
            var sql = @"
                        SELECT 
	                        TOP 5 
	                        a.* 
                        FROM CoachBigCourseInfo a
                        INNER JOIN CoachPrice b ON a.CoachPriceId=b.Id
                        WHERE b.CityCode=@CityCode and a.CreateDate>'2018-05-23 00:00:00.000'
                        ";
            var cmd = CommandHelper.CreateText<CoachBigCourseInfo>(FetchType.Fetch, sql);
            if (string.IsNullOrEmpty(req.Filter.CityId))
            {
                req.Filter.CityId = "75";
            }
            cmd.Params.Add("@CityCode", req.Filter.CityId);
            var result = DbContext.GetInstance().Execute(cmd);
            return result;

        }


    }
}
