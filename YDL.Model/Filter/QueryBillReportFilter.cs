using System.Linq;
using System;
using Newtonsoft.Json;
using YDL.Utility;
using YDL.Model;
using YDL.Core;

namespace YDL.Model
{
    public class QueryBillReportFilter : EntityBase
    {
        /// <summary>
        /// 是否支付日期
        /// </summary>
        public bool IsPayDate { get; set; }

        /// <summary>
        /// 是否包含用户未支付
        /// </summary>
        public bool HasNoPay { get; set; }

        /// <summary>
        /// 开始日期
        /// </summary>
        public DateTime BeginDate { get; set; }

        /// <summary>
        /// 结束日期
        /// </summary>
        public DateTime EndDate { get; set; }

        /// <summary>
        /// 机构编号
        /// </summary>
        public string CompanyId { get; set; }

        /// <summary>
        /// 场馆编号
        /// </summary>
        public string VenueId { get; set; }

    }
}
