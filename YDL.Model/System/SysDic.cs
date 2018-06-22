using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Core;
using YDL.Utility;

namespace YDL.Model
{

    [Table]
    public class SysDic : EntityBase
    {
        /// <summary>
        /// 代码
        /// </summary>
        [Field]
        public string Code { get; set; }

        /// <summary>
        /// 名称索引
        /// </summary>
        [Field]
        public int NameIndex { get; set; }

        /// <summary>
        /// 名称
        /// </summary>
        [Field]
        public string Name { get; set; }

        /// <summary>
        /// 类型
        /// </summary>
        [Field]
        public string Type { get; set; }
        /// <summary>
        /// 课时
        /// </summary>
        public int CourseCount { get; set; }
    }
}
