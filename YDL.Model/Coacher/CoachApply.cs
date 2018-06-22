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
    /// 教练申请表 
    /// </summary>
    [Table]
    public class CoachApply : Coach
    {
        /// <summary>
        /// 教练名称
        /// </summary>
        [Field]
        public new string Name { get; set; }

        /// <summary>
        /// 教练手机
        /// </summary>
        [Field]
        public new string Mobile { get; set; }

        /// <summary>
        /// 身份证号码
        /// </summary>
        [Field]
        public new string CardId { get; set; }
    }
}
