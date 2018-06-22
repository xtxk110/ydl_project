using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    public class GetVenueRelatedFilter : FilterBase
    {
        /// <summary>
        /// 场馆Id
        /// </summary>
        public string VenueId { get; set; }
        /// <summary>
        /// 场馆收入开始时间
        /// </summary>
        public DateTime IncomeBeginTime { get; set; }

        /// <summary>
        /// 场馆收入结束时间
        /// </summary>
        public DateTime IncomeEndTime { get; set; }

    }
}
