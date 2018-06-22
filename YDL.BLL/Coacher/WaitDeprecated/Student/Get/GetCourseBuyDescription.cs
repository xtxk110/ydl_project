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
    /// 获取课程购买说明
    /// </summary>
    public class GetCourseBuyDescription : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetCoachRelatedFilter>>(request);
            var sql = @" 
  SELECT * FROM dbo.CoachPrice WHERE CityCode=@CityId
 ";
            var cmd = CommandHelper.CreateText<CoachPrice>(FetchType.Fetch, sql);
            cmd.Params.Add("@CityId", req.Filter.CityId);

            var result = DbContext.GetInstance().Execute(cmd);
            var obj = result.FirstEntity<CoachPrice>();
            result.Tag = "课程说明 : 大课的有效期是3个月 (从购买日期开始算) ";
            //判断是否有城市价格 
            if (obj != null)
            {
                if (obj.IsEnabled == false)
                {
                    return ResultHelper.Fail(ErrorCode.CITY_NOPRICE_COACH, "此城市暂无价格, 不能购买");
                }
            }
            else
            {
                return ResultHelper.Fail(ErrorCode.CITY_NOPRICE_COACH, "此城市暂无价格, 不能购买");
            }

            //判断教练是否停用
            if (!string.IsNullOrEmpty(req.Filter.CoachId))
            {
                var coachIsEnabled = CoachHelper.Instance.CoachIsEnabled(req.Filter.CoachId);
                if (coachIsEnabled==false)
                {
                    return ResultHelper.Fail(ErrorCode.COACH_DISABLED, "此教练已停用, 不能购买");
                }
            }
           
            return result;

        }



    }
}
