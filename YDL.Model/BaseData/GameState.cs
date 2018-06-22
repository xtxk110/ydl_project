using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    /// <summary>
    /// 比赛状态
    /// </summary>
    public static class GameState
    {
        public static readonly BaseData GROUP = new BaseData { Id = "015", Name = "比赛状态" };

        public static readonly BaseData NOTSTART = new BaseData { Id = "015001", Name = "未发布", GroupId = GROUP.Id, Tag = "015002" };
        public static readonly BaseData SIGN = new BaseData { Id = "015002", Name = "报名中", GroupId = GROUP.Id, Tag = "015003" };
        public static readonly BaseData PREPARE = new BaseData { Id = "015003", Name = "准备中", GroupId = GROUP.Id, Tag = "015004" };
        public static readonly BaseData PROCESSING = new BaseData { Id = "015004", Name = "进行中", GroupId = GROUP.Id, Tag = "015005" };
        public static readonly BaseData FINISH = new BaseData { Id = "015005", Name = "已结束", GroupId = GROUP.Id};

        public static readonly BaseData CANCEL = new BaseData { Id = "015009", Name = "已取消", GroupId = GROUP.Id};

        public static List<BaseData> GetItems(bool containAllItem)
        {
            var result = new List<BaseData> { NOTSTART, SIGN, PREPARE, PROCESSING, FINISH, CANCEL };
            if (containAllItem)
            {
                result.Insert(0, BaseData.ALL_ITEM);
            }
            return result;
        }

        public static BaseData Find(String id)
        {
            List<BaseData> result = GetItems(false);
            foreach (BaseData obj in result)
            {
                if (obj.Id == id)
                {
                    return obj;
                }
            }
            return null;
        }
    }
}
