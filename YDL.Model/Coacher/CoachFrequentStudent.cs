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
    /// 常用学员
    /// </summary>
    [Table]
    public class CoachFrequentStudent : EntityBase
    {

        /// <summary>
        /// 学员姓名
        [Field]
        public string Name { get; set; }
        /// <summary>
        /// 手机号
        /// </summary>
        [Field]
        public string Mobile { get; set; }

        /// <summary>
        /// 创建人Id
        /// </summary>
        [Field]
        public string CreatorId { get; set; }

    }
}