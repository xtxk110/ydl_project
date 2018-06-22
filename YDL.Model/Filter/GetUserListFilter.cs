using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    /// <summary>
    /// 获取用户列表条件
    /// </summary>
    public class GetUserListFilter : FilterBase
    {
        /// <summary>
        /// 按名称昵称
        /// </summary>
        public string Keywords { get; set; }

        /// <summary>
        /// 按是否管理员
        /// </summary>
        public string IsAdmin { get; set; }

        /// <summary>
        /// 用户类型 (值为空时表示获取所有用户, 值为 Coacher 表示获取教练)
        /// </summary>
        public string UserType { get; set; }

        // <summary>
        /// 场馆Id
        /// </summary>
        public string VenueId { get; set; }
        /// <summary>
        /// 集训Id
        /// </summary>
        public string CoachBootcampId { get; set; }
        /// <summary>
        /// 集训的课程Id
        /// </summary>
        public string CoachBootcampCourseId { get; set; }
        /// <summary>
        /// 集训课程开始时间
        /// </summary>
        public DateTime BootcampCourseBeginTime { get; set; }
        /// <summary>
        /// 集训课程结束时间
        /// </summary>
        public DateTime BootcampCourseEndTime { get; set; }
        /// <summary>
        /// 教练id
        /// </summary>
        public string CoachId { get; set; }
    }
}
