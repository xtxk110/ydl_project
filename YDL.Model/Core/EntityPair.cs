using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    /// <summary>
    /// 删除实体辅助类
    /// </summary>
    public class EntityPair
    {
        /// <summary>
        /// 表名
        /// </summary>
        public string Table { get; set; }
        /// <summary>
        /// 字段
        /// </summary>
        public string Field { get; set; }
        /// <summary>
        /// 字段值（多个则逗号隔开）
        /// </summary>
        public string Values { get; set; }

        public EntityPair(String table, String field, String values)
        {
            Table = table;
            Field = field;
            Values = values;
        }
    }
}
