using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    /// <summary>
    ///俱乐部相关的过滤
    /// </summary>
    public class GetClubRelatedFilter : FilterBase
    {
        /// <summary>
        /// 俱乐部Id
        /// </summary>
        public string ClubId { get; set; }

    }
}
