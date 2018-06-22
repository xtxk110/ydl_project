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
    public class MobileValCode : EntityBase
    {
        /// <summary>
        /// 业务类型
        /// </summary>
        [Field]
        public string Code { get; set; }
    }
}
