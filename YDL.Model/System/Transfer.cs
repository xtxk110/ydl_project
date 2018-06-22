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
    /// 业务单据移交
    /// </summary>
    [Table]
    public class Transfer : EntityBase
    {
        /// <summary>
        /// 业务类型
        /// </summary>
        [Field]
        public string MasterType { get; set; }

        /// <summary>
        /// 业务编号
        /// </summary>
        [Field]
        public string MasterId { get; set; }

        /// <summary>
        /// 移交目标人
        /// </summary>
        [Field]
        public string TargetUserId { get; set; }

        /// <summary>
        /// 移交人
        /// </summary>
        [Field]
        public string CreatorId { get; set; }
    }
}
