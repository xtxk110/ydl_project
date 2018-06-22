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
    /// 场馆签到签退
    /// </summary>
    [Table]
    public class VenueSignInOut : EntityBase
    {
        /// <summary>
        /// 场馆Id
        /// </summary>
        [Field]
        public string VenueId { get; set; }

        /// <summary>
        /// 教练Id
        /// </summary>
        [Field]
        public string CoacherUserId { get; set; }

        /// <summary>
        /// 签到时间
        /// </summary>
        [Field(dataType: DataType.DateTime)]
        public DateTime? SignInTime { get; set; }

        /// <summary>
        /// 签退时间
        /// </summary>
        [Field(dataType: DataType.DateTime)]
        public DateTime? SignOutTime { get; set; }



    }
}
