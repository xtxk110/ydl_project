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
    /// 获取已上课列表
    /// </summary>
    public class GetHaveBeenCourseList_186 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetCoachRelatedFilter>>(request);
            Response rsp = ResultHelper.CreateResponse();
            if (req.Filter.CourseTypeId==CoachDic.BootcampCourse)
            {
                //集训课程
                var cmd = CommandHelper.CreateProcedure<CoachCourse>(text: "GetBootcampHaveBeenCourseList");
                cmd.Params.Add(CommandHelper.CreateParam("@StudentId", req.Filter.CurrentUserId));
                cmd.CreateParamPager(req.Filter);

                rsp = DbContext.GetInstance().Execute(cmd);
                rsp.SetRowCount();
            }
            else
            {
                //常规课程
                var cmd = CommandHelper.CreateProcedure<CoachCourse>(text: "GetCourseList");
                cmd.Params.Add(CommandHelper.CreateParam("@ReservedPersonId", req.Filter.CurrentUserId));
                cmd.Params.Add(CommandHelper.CreateParam("@CourseType", req.Filter.CourseTypeId));
                cmd.CreateParamPager(req.Filter);

                rsp = DbContext.GetInstance().Execute(cmd);
                rsp.SetRowCount();
            }

         

            return rsp;
        }


    }
}
