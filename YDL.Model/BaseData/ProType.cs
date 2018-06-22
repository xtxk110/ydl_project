using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    public static class ProType
    {
        public static readonly BaseData GROUP = new BaseData { Id = "001", Name = "专业业余运动员" };

        public static readonly BaseData PRO = new BaseData { Id = "001001", Name = "专业", GroupId = GROUP.Id };
        public static readonly BaseData NOT_PRO = new BaseData { Id = "001002", Name = "业余", GroupId = GROUP.Id };

        public static List<BaseData> GetItems(bool containAllItem)
        {
            var result = new List<BaseData> { PRO, NOT_PRO };
            if (containAllItem)
            {
                result.Insert(0, BaseData.ALL_ITEM);
            }
            return result;
        }
    }
}
