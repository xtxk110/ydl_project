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
    /// 获取预约人员详情
    /// </summary>
    public class GetOrderPersonDetail : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetSystemManageRelatedFilter>>(request);
            var sql = @"
  SELECT 
	a.*,
	b.HeadUrl,
	b.Sex,
	b.Code,
	c.Name  AS CityName,
    a.CreateDate AS ApplyTime
FROM dbo.CoachOrderTrialCourse a
INNER JOIN dbo.UserAccount b ON a.StudentId =b.Id  
LEFT JOIN dbo.City c ON a.CityCode=c.CityCode
WHERE a.StudentId=@StudentId
";
            var cmd = CommandHelper.CreateText<CoachOrderTrialCourse>(FetchType.Fetch, sql);
            cmd.Params.Add("@StudentId", req.Filter.StudentId);
            var result = DbContext.GetInstance().Execute(cmd);
            return result;

        }


    }
}
