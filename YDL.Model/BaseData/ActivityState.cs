using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    /// <summary>
    /// 活动状态
    /// </summary>
    public static class ActivityState
    {
        public static readonly BaseData PROCESSING = new BaseData { Id = "005001", Name = "进行中" };
        public static readonly BaseData FINISH = new BaseData { Id = "005005", Name = "已结束" };
        public static readonly BaseData CANCEL = new BaseData { Id = "005009", Name = "已取消" };

        public static List<BaseData> GetItems(bool containAllItem)
        {
            var result = new List<BaseData> { PROCESSING, FINISH, CANCEL };
            if (containAllItem)
            {
                result.Insert(0, BaseData.ALL_ITEM);
            }
            return result;
        }
    }
}
