using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Core;
using YDL.Utility;

namespace YDL.Model
{
    public class QueryRechargeReportFilter : EntityBase
    {
        /// <summary>
        /// 年份
        /// </summary>
        public int Year { get; set; }

        /// <summary>
        /// 开始月
        /// </summary>
        public int BeginMonth { get; set; }

        /// <summary>
        /// 结束月
        /// </summary>
        public int EndMonth { get; set; }
    }
}
