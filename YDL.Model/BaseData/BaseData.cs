using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using YDL.Core;
using YDL.Utility;

namespace YDL.Model
{
    /// <summary>
    /// 基础数据
    /// </summary>
    [Table]
    public class BaseData : EntityBase
    {
        public static readonly BaseData ALL_ITEM = new BaseData { Id = Constant.Str_Empty, Name = "<全部>" };

        //名称
        [Field]
        public string Name { get; set; }

        //组编号
        [Field]
        public string GroupId { get; set; }

        //排序好
        [Field(dataType: DataType.Int32)]
        public int SortIndex { get; set; }

        //是否启用
        [Field]
        public bool IsEnable { get; set; }

        public object Tag2 { get; set; }

        public static BaseData find(List<BaseData> list, String id)
        {
            foreach (BaseData obj in list)
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
