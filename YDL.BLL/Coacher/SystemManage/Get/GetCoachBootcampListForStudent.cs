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
    /// 获取集训列表, 在学员我的课程里面查看
    /// </summary>
    public class GetCoachBootcampListForStudent : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetSystemManageRelatedFilter>>(request);
            var cmd = CommandHelper.CreateProcedure<CoachBootcamp>(text: "sp_GetCoachBootcampListForStudent");
            cmd.Params.Add("@StudentUserId", req.Filter.StudentId);
            cmd.CreateParamPager(req.Filter);

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();
            return result;

        }

      

    }
}
