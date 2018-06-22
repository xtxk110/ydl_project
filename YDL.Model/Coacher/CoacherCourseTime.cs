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
    /// 课程表时间间隔列表
    /// </summary>
    public class CoacherCourseTime : EntityBase
    {
        /// <summary>
        /// 课程表时间间隔列表
        /// </summary>
        public List<string> TimeList { get; set; }
    }

}