using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    public static class UserType
    {
        public static readonly BaseData USER = new BaseData { Id = "017001", Name = "个人" };
        public static readonly BaseData ACTIVITY = new BaseData { Id = "017002", Name = "活动" };
        public static readonly BaseData CLUB = new BaseData { Id = "017003", Name = "俱乐部" };
        public static readonly BaseData VENUE = new BaseData { Id = "017004", Name = "场馆" };
        public static readonly BaseData GAME = new BaseData { Id = "017005", Name = "赛事" };
        public static readonly BaseData SYSTEM = new BaseData { Id = "017099", Name = "系统" };

        public static List<BaseData> GetItems(bool containAllItem)
        {
            var result = new List<BaseData> { ACTIVITY, CLUB, VENUE, GAME, USER, SYSTEM };
            if (containAllItem)
            {
                result.Insert(0, BaseData.ALL_ITEM);
            }
            return result;
        }
    }
}
