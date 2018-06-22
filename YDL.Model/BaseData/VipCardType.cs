using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    /// <summary>
    /// 会员卡套卡类型
    /// </summary>
    public static class VipCardType
    {
        public static readonly BaseData MONTH = new BaseData { Id = "018001", Name = "月卡", Tag = 1 };
        public static readonly BaseData QUARTER = new BaseData { Id = "018002", Name = "季卡", Tag = 3 };
        public static readonly BaseData YEAR = new BaseData { Id = "018003", Name = "年卡", Tag = 12 };

        public static readonly BaseData CARD = new BaseData { Id = "018005", Name = "套卡" };
        public static readonly BaseData TIME = new BaseData { Id = "018006", Name = "次卡" };

        public static List<BaseData> GetItems(bool containAllItem)
        {
            var result = new List<BaseData> { MONTH, QUARTER, YEAR, CARD, TIME };
            if (containAllItem)
            {
                result.Insert(0, BaseData.ALL_ITEM);
            }
            return result;
        }

        public static List<BaseData> GetCardItems(bool containAllItem)
        {
            var result = new List<BaseData> { MONTH, QUARTER, YEAR };
            if (containAllItem)
            {
                result.Insert(0, BaseData.ALL_ITEM);
            }
            return result;
        }
    }
}
