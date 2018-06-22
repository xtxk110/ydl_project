using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    public class NameOption
    {
        public static readonly BaseData Pet = new BaseData { Id = "020001", Name = "昵称" };
        public static readonly BaseData Name = new BaseData { Id = "020002", Name = "姓名" };
        //public static readonly BaseData PetAndName = new BaseData { Id = "020003", Name = "昵称-姓名" };

        public static List<BaseData> GetItems(bool containAllItem)
        {
            var result = new List<BaseData> { Pet, Name };
            if (containAllItem)
            {
                result.Insert(0, BaseData.ALL_ITEM);
            }
            return result;
        }
    }
}
