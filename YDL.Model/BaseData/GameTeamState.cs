using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    /// <summary>
    /// 参赛者报名状态
    /// </summary>
    public class GameTeamState
    {
        public static readonly BaseData GROUP = new BaseData { Id = "012", Name = "比赛报名状态" };

        public static readonly BaseData PROCESSING = new BaseData { Id = "012001", Name = "审核中", GroupId = GROUP.Id };
        public static readonly BaseData PASS = new BaseData { Id = "012002", Name = "已通过", GroupId = GROUP.Id };
        public static readonly BaseData REFUSE = new BaseData { Id = "012003", Name = "已取消", GroupId = GROUP.Id };

        public static List<BaseData> GetItems(bool containAllItem)
        {
            var result = new List<BaseData> { PROCESSING, PASS, REFUSE };
            if (containAllItem)
            {
                result.Insert(0, BaseData.ALL_ITEM);
            }
            return result;
        }

        public static BaseData find(String id)
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
