using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    /// <summary>
    /// 乒乓球对战方式
    /// </summary>
    public static class TTBattleStyle
    {
        public static readonly BaseData GROUP = new BaseData { Id = "007", Name = "乒乓球对战方式" };

        //Tag代表人数，团体为0；Tag2代表IsTeam
        public static readonly BaseData MAN_ONE = new BaseData { Id = "007001", Name = "男单", GroupId = GROUP.Id, Tag = 1, Tag2 = false };
        public static readonly BaseData MAN_TWO = new BaseData { Id = "007002", Name = "男双", GroupId = GROUP.Id, Tag = 2, Tag2 = false };

        public static readonly BaseData WOMAN_ONE = new BaseData { Id = "007003", Name = "女单", GroupId = GROUP.Id, Tag = 1, Tag2 = false };
        public static readonly BaseData WOMAN_TWO = new BaseData { Id = "007004", Name = "女双", GroupId = GROUP.Id, Tag = 2, Tag2 = false };

        public static readonly BaseData MIXED = new BaseData { Id = "007005", Name = "混双", GroupId = GROUP.Id, Tag = 2, Tag2 = false };

        public static readonly BaseData MAN_TEAM = new BaseData { Id = "007006", Name = "男团", GroupId = GROUP.Id, Tag = 0, Tag2 = true };
        public static readonly BaseData WOMAN_TEAM = new BaseData { Id = "007007", Name = "女团", GroupId = GROUP.Id, Tag = 0, Tag2 = true };

        public static readonly BaseData ONE = new BaseData { Id = "007009", Name = "单打", GroupId = GROUP.Id, Tag = 1, Tag2 = false };
        public static readonly BaseData DOUBLE = new BaseData { Id = "007010", Name = "双打", GroupId = GROUP.Id, Tag = 2, Tag2 = false };
        public static readonly BaseData MIXED_TEAM = new BaseData { Id = "007011", Name = "混合团体", GroupId = GROUP.Id, Tag = 0, Tag2 = true };

        public static List<BaseData> GetItems(bool containAllItem)
        {
            var result = new List<BaseData> { MAN_ONE, MAN_TWO, WOMAN_ONE, WOMAN_TWO, MIXED, MAN_TEAM, WOMAN_TEAM, MIXED_TEAM, DOUBLE, ONE };
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
