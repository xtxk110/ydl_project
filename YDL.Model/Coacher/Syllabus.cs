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
    /// 课程表(教练学员公用此实体)
    /// </summary>
    [Table]
    public class Syllabus : EntityBase
    {
        /// <summary>
        /// 城市名称
        /// </summary>
        [Field(IsUpdate = false)]
        public string CityName { get; set; }

    }
}