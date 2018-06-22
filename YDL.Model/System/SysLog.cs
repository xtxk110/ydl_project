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
    /// 系统日志
    /// </summary>
    [Table]
    public class SysLog : EntityBase
    {
        /// <summary>
        /// 事项
        /// </summary>
        [Field]
        public string Title { get; set; }

        /// <summary>
        /// 关联数据编号
        /// </summary>
        [Field]
        public string SourceId { get; set; }

        /// <summary>
        /// 操作人
        /// </summary>
        [Field]
        public string CreatorId { get; set; }
    }
}
