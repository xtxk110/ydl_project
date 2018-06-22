using Newtonsoft.Json;
using YDL.Map;
using YDL.Core;
using YDL.Model;
using System.Linq;
using System.Collections.Generic;

namespace YDL.BLL
{
    public class ActivityHelper
    {
        public static Response GetActivityUserList(GetActivityUserListFilter filter)
        {

            var cmd = CommandHelper.CreateProcedure<ActivityUser>(text: "sp_GetActivityUserList");
            cmd.Params.Add(CommandHelper.CreateParam("@activityId", filter.ActivityId));
            cmd.Params.Add(CommandHelper.CreateParam("@petName", filter.PetName));
            cmd.CreateParamPager(filter);

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();

            return result;
        }

        /// <summary>
        /// 活动报名
        /// </summary>
        /// <returns></returns>
        public static Response ActivitySignUp(ActivityUser activityUser)
        {
            List<EntityBase> entities = new List<EntityBase>();
            entities.Add(activityUser);
            if (activityUser.RowState == RowState.Added)
            {
                activityUser.TrySetNewEntity();
            }

            return DbContext.GetInstance().Execute(CommandHelper.CreateSave(entities));
        }


        /// <summary>
        /// 活动成员是否存在
        /// </summary>
        /// <returns></returns>
        public static bool ActivityUserIsExist(string activityId, string userId)
        {
            string sql = @"
SELECT  COUNT(*)
FROM    dbo.ActivityUser
WHERE   ActivityId = @activityId AND UserId = @userId
           ";
            var cmdVal = CommandHelper.CreateText<ClubUser>(FetchType.Scalar, sql);
            cmdVal.Params.Add("@activityId", activityId);
            cmdVal.Params.Add("@userId", userId);
            var result = DbContext.GetInstance().Execute(cmdVal);

            return (int)result.Tag > 0;
        }
    }
}
