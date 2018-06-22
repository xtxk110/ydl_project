using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    /// <summary>
    /// 小组循环每场状态
    /// </summary>
    public class GameLoopState
    {
        public static readonly BaseData GROUP = new BaseData { Id = "011", Name = "小组循环每场状态" };

        public static readonly BaseData NOTSTART = new BaseData { Id = "011001", Name = "未开始", GroupId = GROUP.Id };
        public static readonly BaseData PROCESSING = new BaseData { Id = "011002", Name = "进行中", GroupId = GROUP.Id };
        public static readonly BaseData FINISH = new BaseData { Id = "011003", Name = "已结束", GroupId = GROUP.Id };      

        public static List<BaseData> GetItems(bool containAllItem)
        {
            var result = new List<BaseData> { PROCESSING, FINISH, NOTSTART };
            if (containAllItem)
            {
                result.Insert(0, BaseData.ALL_ITEM);
            }
            return result;
        }
    }
}
