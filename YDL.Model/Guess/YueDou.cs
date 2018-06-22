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
    /// 悦豆
    /// </summary>
    [Table]
    public class YueDou : EntityBase
    {

        [Field]
        public string UserId { get; set; }

        /// <summary>
        /// 余额
        /// </summary>
        [Field]
        public int Balance { get; set; }

    }
}
