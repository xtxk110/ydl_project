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
    /// 保存学员是否签到
    /// </summary>
    public class SaveStudentIsSignIn_186 : IServiceBase
    {

        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<CoachCoursePersonInfo>>(request);
            var obj = req.FirstEntity();

            var sql = @"
 UPDATE dbo.CoachCoursePersonInfo 
 SET IsSignIn=@IsSignIn
 WHERE Id=@Id
";
            var cmd = CommandHelper.CreateText<CoachCoursePersonInfo>(FetchType.Execute, sql);
            cmd.Params.Add("@IsSignIn", obj.IsSignIn);
            cmd.Params.Add("@Id", obj.Id);

            var result = DbContext.GetInstance().Execute(cmd);
            return result;

        }


    }
}
