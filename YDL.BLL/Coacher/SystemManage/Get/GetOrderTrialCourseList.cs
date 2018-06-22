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
    /// 获取预约体验课联系人列表
    /// </summary>
    public class GetOrderTrialCourseList : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetSystemManageRelatedFilter>>(request);
            var cmd = CommandHelper.CreateProcedure<CoachOrderTrialCourse>(text: "sp_GetOrderTrialCourseList");
            cmd.Params.Add(CommandHelper.CreateParam("@IsContact", req.Filter.IsContact));
            cmd.CreateParamPager(req.Filter);

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();

            return result;


        }

       


    }
}
