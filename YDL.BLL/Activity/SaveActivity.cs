using System;
using System.Linq;
using System.Collections.Generic;

using Newtonsoft.Json;
using YDL.Core;
using YDL.Map;
using YDL.Model;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 保存活动
    /// </summary>
    public class SaveActivity : IServiceBase
    {
        /// <summary>
        /// 保存活动
        /// </summary>
        /// <param name="currentUser"></param>
        /// <param name="request">Activity</param>
        /// <returns>EmptyEntity</returns>
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<Activity>>(request);
            var activity = req.FirstEntity();

            activity.VenueId = activity.VenueId.GetId();
            activity.CityId = activity.CityId.GetId();
            activity.ClubId = activity.ClubId.GetId();

            List<EntityBase> entites = new List<EntityBase>();
            entites.Add(activity);

            if (activity.RowState == RowState.Added)
            {

                if (!string.IsNullOrEmpty(activity.ClubId))
                {
                    var resultVal = ValidateClubActivity(activity);
                    if ((int)resultVal.Tag == 1)
                    {
                        return ResultHelper.Fail("一家俱乐部每天只能创建一个活动。");
                    }
                }

                activity.State = ActivityState.PROCESSING.Id;
                activity.TrySetNewEntity();
                activity.CreatorId = currentUser.Id;
                entites.Add(createActivityUser(activity));
            }

            activity.CreatorId = activity.CreatorId.GetId();
            activity.ModifyHeadIcon();

            //获取将要保存的图片列表
            activity.GetWillSaveFileList(entites);


            var result = DbContext.GetInstance().Execute(CommandHelper.CreateSave(entites));

            if (activity.ClubId.IsNotNullOrEmpty() && activity.RowState == RowState.Added)
            {
                try
                {
                    SendNotifyToClubUser(activity);
                }
                catch (Exception)
                {
                }
            }

            return result;
        }

        private static void SendNotifyToClubUser(Activity activity)
        {
            var clubUses = ClubHelper.GetClubUserIdList(activity.ClubId);
            if (clubUses.IsNotNullOrEmpty())
            {
                var club = ClubHelper.GetClub(activity.ClubId);
                string msg = string.Format("{0}创建了活动{1}，开始时间{2}。请积极报名参加。", club.Name, activity.Name, activity.BeginTime.ToString(Constant.DateTimeFormatCN));
                JPushHelper.SendNotify(MasterType.ACTIVITY.Id, activity.Id, msg, clubUses);
            }
        }


        private static Response ValidateVip(User currentUser, Activity activity)
        {
            var cmd = CommandHelper.CreateProcedure(FetchType.Scalar, "sp_ValidateUserSign");
            cmd.CreateParamUser(currentUser.Id);
            cmd.Params.Add("@cityId", activity.CityId.GetId());
            cmd.Params.Add("@venueId", activity.VenueId.GetId());
            cmd.Params.Add("@date", DateTime.Now.Date);
            var result = DbContext.GetInstance().Execute(cmd);
            return result;
        }

        private static Response ValidateClubActivity(Activity activity)
        {
            var cmd = CommandHelper.CreateProcedure(FetchType.Scalar, "sp_ValidateClubActivity");
            cmd.Params.Add("@clubId", activity.ClubId);
            cmd.Params.Add("@date", activity.BeginTime, DataType.DateTime);
            var result = DbContext.GetInstance().Execute(cmd);
            return result;
        }

        private static ActivityUser createActivityUser(Activity activity)
        {
            ActivityUser user = new ActivityUser();
            user.SetNewId();
            user.SetCreateDate();
            user.SetRowAdded();
            user.ActivityId = activity.Id;
            user.UserId = activity.CreatorId;
            user.IsJoined = false;
            user.Remark = "活动负责人";
            return user;
        }

    }
}
