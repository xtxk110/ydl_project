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
    /// 活动列表
    /// </summary>
    public class GetActivityList : IService
    {
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetActivityListFilter>>(request);
            var cmd = CommandHelper.CreateProcedure<Activity>(text: "sp_GetActivityList");
            cmd.Params.Add(CommandHelper.CreateParam("@clubId", req.Filter.ClubId));
            cmd.Params.Add(CommandHelper.CreateParam("@cityId", req.Filter.CityId));
            cmd.Params.Add(CommandHelper.CreateParam("@type", req.Filter.Type));
            cmd.Params.Add(CommandHelper.CreateParam("@name", req.Filter.Name));
            cmd.Params.Add(CommandHelper.CreateParam("@isClubActivity", req.Filter.IsClubActivity));

            cmd.CreateParamPager(req.Filter);

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();
            SetActivityUserList(result);

            return result;
        }

        //设置每个活动的成员列表
        public void SetActivityUserList(Response result)
        {
            GetActivityUserListFilter userFilter = new GetActivityUserListFilter();
            userFilter.PageIndex = 1;
            userFilter.PageSize = 10;//此处写死10个用做头像列表用

            foreach (var item in result.Entities)
            {
                var activity = item as Activity;
                userFilter.ActivityId = activity.Id;
                var tempResult = ActivityHelper.GetActivityUserList(userFilter);
                activity.ActivityUserList = tempResult.Entities.ToList<EntityBase, ActivityUser>();
                activity.ActivityUserTotal = tempResult.RowCount;
            }
        }

    }
}
