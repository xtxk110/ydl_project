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
    /// 获取购买时预设信息
    /// </summary>
    public class GetCourseBuyPresetInfo_186 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetCoachRelatedFilter>>(request);
            Response rsp = new Response();
            //附近的一个场馆
            CoachCourse coachCourse = new CoachCourse();
            coachCourse.Venue = GetVenue(req);
            //课时列表
            List<SysDic> list = new List<SysDic>();
            list.Add(new SysDic() { CourseCount = 10 });
            list.Add(new SysDic() { CourseCount = 30 });
            list.Add(new SysDic() { CourseCount = 50 });
            coachCourse.CourseCountList = list;
            rsp.IsSuccess = true;
            rsp.Entities.Add(coachCourse);
            //个人信息
            coachCourse.StudentName = UserHelper.GetUserName(currentUser);
            var user = UserHelper.GetUserById(currentUser.Id);
            if (user != null)
            {
                coachCourse.StudentMobile = user.Mobile;
            }

            return rsp;
        }

        /// <summary>
        /// 获取附近第一个场馆(开了定位)或者列表第一个(没开定位)
        /// </summary>
        public Venue GetVenue(Request<GetCoachRelatedFilter> req)
        {

            //赋默认值的参数
            req.Filter.PageIndex = 1;
            req.Filter.PageSize = 1;
            var cmd = CommandHelper.CreateProcedure<Venue>(text: "sp_GetNearbyTeachingPointList");
            cmd.Params.Add(CommandHelper.CreateParam("@Name", req.Filter.Name));
            if (string.IsNullOrEmpty(req.Filter.CityId))
            {
                req.Filter.CityId = "75";
            }
            cmd.Params.Add(CommandHelper.CreateParam("@CityCode", req.Filter.CityId));
            cmd.Params.Add(CommandHelper.CreateParam("@curUserLng", req.Filter.CurUserLng, DataType.Double));
            cmd.Params.Add(CommandHelper.CreateParam("@curUserLat", req.Filter.CurUserLat, DataType.Double));
            cmd.CreateParamUser(req.Filter.StudentId.GetId()); //传当前用户Id

            //赋默认值的参数
            cmd.Params.Add(CommandHelper.CreateParam("@isUseVip", ""));
            cmd.Params.Add(CommandHelper.CreateParam("@isOnlySelf", false));
            cmd.Params.Add(CommandHelper.CreateParam("@isAll", false));
            cmd.Params.Add(CommandHelper.CreateParam("@state", ""));

            cmd.CreateParamPager(req.Filter);

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();

            return result.FirstEntity<Venue>();
        }


    }
}
