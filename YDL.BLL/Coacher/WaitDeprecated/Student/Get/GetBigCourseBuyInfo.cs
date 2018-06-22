using System;
using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Core;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 获取大课购买时展示的信息
    /// </summary>
    public class GetBigCourseBuyInfo : IServiceBase
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
            if (obj != null)
            {
                if (obj.IsEnabled == false)
                {
                    result.IsSuccess = false;
                    return ResultHelper.Fail(ErrorCode.CITY_NOPRICE_COACH, "此城市暂无价格, 不能购买");
                }
                obj.BigCourseValidDate = UserHelper.GetConfig().BigCourseValidDays / 30;
                obj.CityCode = obj.CityCode.Trim();
            }
            else
            {
                return ResultHelper.Fail(ErrorCode.CITY_NOPRICE_COACH, "此城市暂无价格, 不能购买");
            }

            return result;

        }


    }
}
