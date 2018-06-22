using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    /// <summary>
    /// 群活动类型
    /// </summary>
    public static class ActivityType
    {
        public static readonly BaseData GROUP = new BaseData { Id = "004", Name = "握拍方式" };

        public static readonly BaseData MEET = new BaseData { Id = "004001", Name = "普通约球", GroupId = GROUP.Id };
        public static readonly BaseData ACTIVITY = new BaseData { Id = "004002", Name = "群活动", GroupId = GROUP.Id };
        public static readonly BaseData SIGN = new BaseData { Id = "004003", Name = "个人现场签到", GroupId = GROUP.Id };

        public static List<BaseData> GetItems(bool containAllItem)
        {
            var result = new List<BaseData> { MEET, ACTIVITY, SIGN };
            if (containAllItem)
            {
                result.Insert(0, BaseData.ALL_ITEM);
            }
            return result;
        }
    }
}
