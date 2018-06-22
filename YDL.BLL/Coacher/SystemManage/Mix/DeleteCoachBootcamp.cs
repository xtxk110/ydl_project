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
    /// 删除集训
    /// </summary>
    public class DeleteCoachBootcamp : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<CoachBootcamp>>(request);
            var obj = req.FirstEntity();
            if (!PermissionCheck.Instance.IsSystemManager(currentUser.Id))
            {
                return ResultHelper.Fail("你没有此权限, 只有系统管理员才能删除");
            }
            //有学员报名不能删除集训
            if (IsHaveStudent(obj)==true)
            {
                return ResultHelper.Fail("有学员报名, 不能删除集训");
            }

            var sql = @"
                DELETE FROM dbo.CoachBootcamp WHERE Id=@Id ;
                DELETE FROM dbo.CoachBootcampCourse WHERE CoachBootcampId=@Id ;
";
            var cmd = CommandHelper.CreateText<CoachBootcamp>(FetchType.Execute, sql);
            cmd.Params.Add("@Id", obj.Id);

            var result = DbContext.GetInstance().Execute(cmd);
            return result;

        }

        public bool IsHaveStudent(CoachBootcamp obj)
        {
            string sql = @"
SELECT 
    TOP 1 * 
FROM dbo.CoachStudentMoney 
WHERE CoachBootcampId=@CoachBootcampId
";
            var cmd = CommandHelper.CreateText<Coacher>(FetchType.Fetch, sql);
            cmd.Params.Add("@CoachBootcampId", obj.Id);
            var result = DbContext.GetInstance().Execute(cmd);
            if (result.Entities.Count > 0)
            {
                return true;
            }
            else
            {
                return false;
            }

        }


    }
}
