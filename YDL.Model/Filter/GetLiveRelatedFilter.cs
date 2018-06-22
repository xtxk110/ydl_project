using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
 
    public class GetLiveRelatedFilter : FilterBase
    {


        /// <summary>
        /// 直播Id
        /// </summary>
        public string LiveId { get; set; }

        /// <summary>
        /// 用户编码
        /// </summary>
        public string UserCode { get; set; }

        /// <summary>
        /// 比赛Id
        /// </summary>
        public string GameId { get; set; }
        
    }

}
