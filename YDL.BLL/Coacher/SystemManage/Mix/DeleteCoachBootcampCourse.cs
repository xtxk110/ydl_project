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
    /// 删除集训课程
    /// </summary>
    public class DeleteCoachBootcampCourse : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<CoachBootcampCourse>>(request);
            var obj = req.FirstEntity();

            var sql = @"
                DELETE FROM dbo.CoachBootcampCourse WHERE Id=@Id ;
";
            var cmd = CommandHelper.CreateText<CoachBootcampCourse>(FetchType.Execute, sql);
            cmd.Params.Add("@Id", obj.Id);

            var result = DbContext.GetInstance().Execute(cmd);
            return result;

        }


    }
}
