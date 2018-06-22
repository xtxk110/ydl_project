using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    /// <summary>
    /// 加入俱乐部请求状态
    /// </summary>
    public static class ClubRequestState
    {
        public static readonly BaseData PROCESSING = new BaseData { Id = "003001", Name = "申请中" };
        public static readonly BaseData PASS = new BaseData { Id = "003002", Name = "通过"};
        public static readonly BaseData REFUSE = new BaseData { Id = "003003", Name = "拒绝"};

        public static List<BaseData> GetItems(bool containAllItem)
        {
            var result = new List<BaseData> { PROCESSING, PASS, REFUSE };
            if (containAllItem)
            {
                result.Insert(0, BaseData.ALL_ITEM);
            }
            return result;
        }
    }
}
