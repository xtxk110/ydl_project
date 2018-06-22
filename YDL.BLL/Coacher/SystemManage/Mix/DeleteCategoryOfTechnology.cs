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
    /// 删除技术类别
    /// </summary>
    public class DeleteCategoryOfTechnology : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<SysDic>>(request);
            var obj = req.FirstEntity();
            if (IsInUse(obj.Id))
            {
                return ResultHelper.Fail("此技术类别已使用, 不能删除");
            }

            var sql = @"DELETE  FROM dbo.SysDic   WHERE Id=@Id";
            var cmd = CommandHelper.CreateText<ClubUser>(FetchType.Execute, sql);
            cmd.Params.Add("@Id", obj.Id);

            var result = DbContext.GetInstance().Execute(cmd);
            return result;

        }

        public bool IsInUse(string CategoryOfTechnologyId)
        {

            string sql = @"
SELECT TOP 1 Id FROM dbo.CoachCourse WHERE CategoryOfTechnologyId=@CategoryOfTechnologyId
";
            var cmd = CommandHelper.CreateText<SysDic>(FetchType.Fetch, sql);
            cmd.Params.Add("@CategoryOfTechnologyId", CategoryOfTechnologyId);
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
