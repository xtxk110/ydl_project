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
    /// 举报
    /// </summary>
    [Table]
    public class WhistleBlowing : EntityBase
    {

        /// <summary>
        /// 举报内容Id
        /// </summary>
        [Field]
        public string ContentId { get; set; }

        /// <summary>
        /// 举报的类型
        /// </summary>
        [Field]
        public string WhistleBlowingType { get; set; }

        /// <summary>
        /// 举报备注
        /// </summary>
        [Field]
        public string Remark { get; set; }

        /// <summary>
        /// 举报人Id
        /// </summary>
        [Field]
        public string WhistleBlowingUserId { get; set; }

    }
}
