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
    /// 获取教练收入
    /// 业务逻辑: 教练收入和机构收入的 数据来源都是 结束课程 接口 SaveCoachCourseEnd 产生的
    /// </summary>
    public class GetCoachIncome : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetSystemManageRelatedFilter>>(request);
            var sql = @"
  SELECT 
	SUM(CoachRealIncome)   AS TotalIncome
  FROM dbo.CoachIncome
  WHERE CreateDate>=@BeginTime AND CreateDate<=@EndTime
        AND CoachId=@CoachId 

";
            var cmd = CommandHelper.CreateText<CoachIncome>(FetchType.Fetch, sql);
            cmd.Params.Add("@BeginTime", req.Filter.CoachIncomeBeginTime);
            cmd.Params.Add("@EndTime", req.Filter.CoachIncomeEndTime.AddDays(1).AddMinutes(-1));
            cmd.Params.Add("@CoachId", req.Filter.CoachId);

            var result = DbContext.GetInstance().Execute(cmd);
            return result;

        }


    }
}
