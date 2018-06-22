using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    /// <summary>
    /// 创建场馆账单
    /// </summary>
    public class CreateVipVenueBillFilter
    {
        /// <summary>
        /// 城市编号
        /// </summary>
        public string CityId { get; set; }

        /// <summary>
        /// 场馆编号
        /// </summary>
        public string VenueId { get; set; }

        /// <summary>
        /// 开始日期
        /// </summary>
        public DateTime BeginDate { get; set; }

        /// <summary>
        /// 截止日期
        /// </summary>
        public DateTime EndDate { get; set; }
    }
}
