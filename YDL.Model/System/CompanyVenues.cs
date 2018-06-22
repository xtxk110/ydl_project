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
    /// 机构签约场馆
    /// </summary>
    [Table]
    public class CompanyVenues : EntityBase
    {
        /// <summary>
        /// 机构
        /// </summary>
        [Field]
        public string CompanyId { get; set; }

        /// <summary>
        /// 场馆
        /// </summary>
        [Field]
        public string VenueId { get; set; }
    }
}
