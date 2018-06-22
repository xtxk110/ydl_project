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
    /// 联系人类别
    /// </summary>
    [Table]
    public class ContactCategory : EntityBase
    {
        /// <summary>
        /// 名称
        /// </summary>
        [Field]
        public string Name { get; set; }

        /// <summary>
        /// 个数
        /// </summary>
        [Field(dataType: DataType.Int32)]
        public int Number { get; set; }

    }
}
