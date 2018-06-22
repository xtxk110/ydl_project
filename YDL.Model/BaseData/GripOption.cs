using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    public static class GripOption
    {
        public static readonly BaseData GROUP = new BaseData { Id = "002", Name = "握拍方式" };

        public static readonly BaseData PEN = new BaseData { Id = "002001", Name = "直拍", GroupId = GROUP.Id };
        public static readonly BaseData FL = new BaseData { Id = "002002", Name = "横拍", GroupId = GROUP.Id };

        public static List<BaseData> GetItems(bool containAllItem)
        {
            var result = new List<BaseData> { PEN, FL };
            if (containAllItem)
            {
                result.Insert(0, BaseData.ALL_ITEM);
            }
            return result;
        }
    }
}
