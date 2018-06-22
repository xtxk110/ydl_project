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
    /// 获取教练价格列表
    /// </summary>
    public class GetCoachPriceList : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetSystemManageRelatedFilter>>(request);
            var cmd = CommandHelper.CreateProcedure<CoachPrice>(text: "sp_GetCoachPriceList");
            cmd.CreateParamPager(req.Filter);

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();
            foreach (var item in result.Entities)
            {
                var obj = item as CoachPrice;
                obj.CityCode = obj.CityCode.Trim();
                obj.BigCourseInfoList = GetBigCourseInfo(item.Id);
            }
            return result;

        }
        /// <summary>
        /// 获取对应大课信息
        /// </summary>
        /// <param name="CoachPriceId"></param>
        /// <returns></returns>
        private List<CoachBigCourseInfo> GetBigCourseInfo(string CoachPriceId)
        {
            string sql = "";
            sql = @"SELECT * FROM dbo.CoachBigCourseInfo WHERE CoachPriceId=@CoachPriceId";
            var cmd = CommandHelper.CreateText<CoachBigCourseInfo>(FetchType.Fetch, sql);
            cmd.Params.Add("@CoachPriceId", CoachPriceId);
            var result = DbContext.GetInstance().Execute(cmd);
            var data = result.Entities.ToList<EntityBase, CoachBigCourseInfo>();
            return data;
        }


    }
}
