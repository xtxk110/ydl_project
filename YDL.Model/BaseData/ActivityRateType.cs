using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    /// <summary>
    /// 活动评价项目
    /// </summary>
    public static class ActivityRateType
    {
        public static readonly BaseData GROUP = new BaseData { Id = "006", Name = "活动评价项目" };

        public static readonly BaseData ORGANIZATION = new BaseData { Id = "006001", Name = "组织情况", GroupId = GROUP.Id };
        public static readonly BaseData VENUE = new BaseData { Id = "006002", Name = "场馆情况", GroupId = GROUP.Id };

        public static List<BaseData> GetItems(bool containAllItem)
        {
            var result = new List<BaseData> { ORGANIZATION, VENUE };
            if (containAllItem)
            {
                result.Insert(0, BaseData.ALL_ITEM);
            }
            return result;
        }
    }
}
