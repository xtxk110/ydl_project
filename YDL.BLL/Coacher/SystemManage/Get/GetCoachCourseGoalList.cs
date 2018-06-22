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
    /// 获取课程目标列表
    /// </summary>
    public class GetCoachCourseGoalList_186 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetSystemManageRelatedFilter>>(request);
            var sql = @"
   SELECT * FROM dbo.SysDic WHERE Type='乒乓球课程目标'
";
            var cmd = CommandHelper.CreateText<SysDic>(FetchType.Fetch, sql);
            var result = DbContext.GetInstance().Execute(cmd);
            return result;

        }


    }
}
