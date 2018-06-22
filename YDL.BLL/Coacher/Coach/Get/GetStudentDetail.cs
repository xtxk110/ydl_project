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
    /// 获取学员详情
    /// </summary>
    public class GetStudentDetail_186 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetCoachRelatedFilter>>(request);
            string sql = @"
 SELECT 
	a.* ,
	b.TrainingPlanContent
 FROM dbo.UserAccount a
 LEFT JOIN dbo.CoachTrainingPlan b ON a.Id=b.StudentId AND b.CoachId=@CoachId
 WHERE a.Id=@Id             
";

            var cmd = CommandHelper.CreateText<User>(FetchType.Fetch, sql);
            cmd.Params.Add("@Id", req.Filter.StudentId);
            cmd.Params.Add("@CoachId", req.Filter.CurrentUserId);
            var result = DbContext.GetInstance().Execute(cmd);
            var user = result.FirstEntity<User>();
            user.CardName = UserHelper.GetUserName(user);
            return result;

        }

        
    }


}
