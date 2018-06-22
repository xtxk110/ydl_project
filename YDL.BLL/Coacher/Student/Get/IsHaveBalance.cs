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
    /// 获取学员是否有余额
    /// </summary>
    public class IsHaveBalance_186 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetCoachRelatedFilter>>(request);

            string sql = "";
            sql = @"
 SELECT 
	ISNULL(SUM(Amount),0) AS Amount
 FROM dbo.CoachStudentMoney 
 WHERE 
    StudentUserId=@StudentUserId
 AND Deadline>GETDATE() /*没过期*/
 AND CourseTypeId!='027005' /*剔除集训课余额*/
 
";


            var cmd = CommandHelper.CreateText<CoachStudentMoney>(FetchType.Fetch, sql);
            cmd.Params.Add("@StudentUserId", req.Filter.CurrentUserId);
            var result = DbContext.GetInstance().Execute(cmd);
            CoachStudentMoney obj = result.FirstEntity<CoachStudentMoney>();
            
            if (obj.Amount == 0)
            {
                result.Tag = false;
            }
            else
            {
                result.Tag = true;

            }
            result.Entities.Clear();
            return result;
        }
    }
}
