using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    public class CostType
    {
        public static readonly string GroupId = "022";

        public static readonly BaseData VENUE = new BaseData { Id = "022001", Name = "场地费" };
        public static readonly BaseData COACHCOST = new BaseData { Id = "022002", Name = "教练费用" };
        public static readonly BaseData YUEDOUCOST = new BaseData { Id = "022003", Name = "悦豆费用" };

        public static readonly BaseData OTHER = new BaseData { Id = "022099", Name = "其它" };

        public static List<BaseData> GetItems(bool containAllItem)
        {
            var result = new List<BaseData> { VENUE, COACHCOST,  OTHER };
            if (containAllItem)
            {
                result.Insert(0, BaseData.ALL_ITEM);
            }
            return result;
        }
    }
}
