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
    /// 教学点 教练员
    /// </summary>
    [Table]
    public class CoachTeachingPointCoaches : EntityBase
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
        public string CoacherId { get; set; }


    }
}