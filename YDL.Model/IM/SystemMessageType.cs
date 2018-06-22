using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    /// <summary>
    /// 系统消息类型
    /// </summary>
    public static class SystemMessageType
    {
        /// <summary>
        /// 学员端约课详情
        /// </summary>
        public const string StudentReservedCourseDetail = "StudentReservedCourseDetail";

        /// <summary>
        /// 教练端约课详情
        /// </summary>
        public const string CoachReservedCourseDetail = "CoachReservedCourseDetail";

        /// <summary>
        /// 不要跳转
        /// </summary>
        public const string DoNotJump = "";//返回空表示不要跳转

    }
}
