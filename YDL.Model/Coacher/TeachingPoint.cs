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
    /// 教学点 (其实就是个场馆)
    /// </summary>
    [Table]
    public class TeachingPoint : HeadBase
    {
        /// <summary>
        /// 场馆Id
        /// </summary>
        [Field(IsUpdate = false)]
        public string VenueId { get; set; }

        /// <summary>
        /// 场馆名称
        /// </summary>
        [Field(IsUpdate = false)]
        public string VenueName { get; set; }

        /// <summary>
        /// 是否为教学点
        /// </summary>
        [Field(IsUpdate = false)]
        public bool IsEnableTeachingPoint { get; set; }

        /// <summary>
        /// 课程管理员Id
        /// </summary>
        [Field(IsUpdate = false)]
        public string CourseManagerId { get; set; }

        /// <summary>
        /// 课程管理员姓名
        /// </summary>
        [Field(IsUpdate = false)]
        public string CourseManagerName { get; set; }

        /// <summary>
        /// 教练员Id列表 (逗号分隔)
        /// </summary>
        [Field(IsUpdate = false)]
        public string CoacherIds { get; set; }

        /// <summary>
        /// 教练员列表 (user 实体)
        /// </summary>
        [Field(IsUpdate = false)]
        public List<User> CoacherUserList { get; set; }

        /// <summary>
        /// 教练员Name列表  (逗号分隔)
        /// </summary>
        [Field(IsUpdate = false)]
        public string CoacherNames { get; set; }

        /// <summary>
        /// 球桌数
        /// </summary>
        [Field(IsUpdate = false)]
        public int TableCount { get; set; }

        /// <summary>
        /// 运动类型
        /// </summary>
        [Field(IsUpdate = false)]
        public string SportName { get; set; }

    }
}