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
    /// 获取学员的集训班列表(包括封闭机构和悦动力的)
    /// </summary>
    public class GetStudentBootcampList_189 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetCoachRelatedFilter>>(request);
            var cmd = CommandHelper.CreateProcedure<CoachBootcamp>(text: "sp_GetStudentBootcampList");
            cmd.Params.Add(CommandHelper.CreateParam("@StudentId", req.Filter.StudentId));

            cmd.CreateParamPager(req.Filter);

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();

            return result;
        }


    }
}
