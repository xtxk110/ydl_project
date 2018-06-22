using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using YDL.Core;

namespace YDL.Model
{
    /// <summary>
    /// 编号名称工具类
    /// </summary>
    public class IdNamePair : EntityBase
    {
        /// <summary>
        /// 名称
        /// </summary>
        [Field(isUpdate: false)]
        public string Name { get; set; }
    }
}
