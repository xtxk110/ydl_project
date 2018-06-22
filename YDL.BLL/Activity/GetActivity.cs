
using Newtonsoft.Json;
using YDL.Map;
using YDL.Core;
using YDL.Model;
using System.Linq;
using System.Collections.Generic;
using System;

namespace YDL.BLL
{
    /// <summary>
    /// 获取单个活动信息
    /// </summary>
    public class GetActivity : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<Activity>>(request);
            var cmd = CommandHelper.CreateProcedure<Activity>(text: "sp_GetActivity");
            cmd.Params.Add("@userId", currentUser.Id);
            cmd.Params.Add("@activityId", req.Filter.Id);

            var result = DbContext.GetInstance().Execute(cmd);
            var activity = result.FirstEntity<Activity>();
            activity.ActivityUserList = new List<ActivityUser>();

            GetActivityUserListFilter userFilter = new GetActivityUserListFilter();
            userFilter.ActivityId = req.Filter.Id;
            userFilter.PageIndex = 1;
            userFilter.PageSize = 10;//此处写死10个用做头像列表用
            var tempResult = ActivityHelper.GetActivityUserList(userFilter);
            tempResult.Entities.ForEach(p => activity.ActivityUserList.Add(p as ActivityUser));

            activity.ActivityUserTotal = tempResult.RowCount;
            activity.TryGetFiles();

            return result;
        }
    }

}
