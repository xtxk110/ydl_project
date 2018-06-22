using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    public class GetActivityListFilter : FilterBase
    {
        /// <summary>
        /// 活动俱乐部
        /// </summary>
        public string ClubId { get; set; }

        /// <summary>
        /// 城市编号
        /// </summary>
        public string CityId { get; set; }

        /// <summary>
        /// 活动类型
        /// </summary>
        public string Type { get; set; }

        /// <summary>
        /// 活动名称
        /// </summary>
        public string Name { get; set; }

        /// <summary>
        /// 是否为俱乐部活动
        /// </summary>
        public bool IsClubActivity { get; set; }
    }
}
