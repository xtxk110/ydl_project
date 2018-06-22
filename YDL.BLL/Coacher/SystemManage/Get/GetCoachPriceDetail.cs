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
    /// 获取教练价格详情
    /// </summary>
    public class GetCoachPriceDetail_187 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetSystemManageRelatedFilter>>(request);
            var sql = @"
  SELECT 
	a.*,
	b.Name AS CityName
 FROM dbo.CoachPrice a
 LEFT JOIN dbo.City b ON a.CityCode=b.CityCode
 WHERE a.Id=@Id
";
            var cmd = CommandHelper.CreateText<CoachPrice>(FetchType.Fetch, sql);
            cmd.Params.Add("@Id", req.Filter.CoachPriceId);

            var result = DbContext.GetInstance().Execute(cmd);
            if (result.IsSuccess)
            {
                var obj = result.FirstEntity<CoachPrice>();
                if (obj != null)
                {
                    obj.BigCourseInfoList = GetCoachBigCourseInfoList(obj.Id);
                }
            }

            return result;

        }


        public List<CoachBigCourseInfo> GetCoachBigCourseInfoList(string CoachPriceId)
        {
            var sql = @"
 SELECT * 
 FROM dbo.CoachBigCourseInfo
 WHERE CoachPriceId=@CoachPriceId
";
            var cmd = CommandHelper.CreateText<CoachBigCourseInfo>(FetchType.Fetch, sql);
            cmd.Params.Add("@CoachPriceId", CoachPriceId);

            var result = DbContext.GetInstance().Execute(cmd);
            return result.Entities.ToList<EntityBase, CoachBigCourseInfo>();
        }


    }
}
