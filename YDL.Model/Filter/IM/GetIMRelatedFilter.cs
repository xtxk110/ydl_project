using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    /// <summary>
    /// IM 相关Filter 
    /// </summary>
    public class GetIMRelatedFilter : FilterBase
    {
        public string Identifier { get; set; }

        public string UserCode { get; set; }

        public string ClubId { get; set; }

        /// <summary>
        /// 群Id
        /// </summary>
        public string GroupId { get; set; }

        
    }
}
