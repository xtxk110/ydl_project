using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    /// <summary>
    /// 获取场馆教练培训统计
    /// </summary>
    public class GetVenueCoachStatisticsFilter : FilterBase
    {
        /// <summary>
        /// 
        /// </summary>
        public string VenueId { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public DateTime BeginMonth { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public DateTime EndMonth { get; set; }
    }
}
