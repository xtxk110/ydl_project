using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    /// <summary>
    /// 获取用户签到记录Filter
    /// </summary>
    public class GetUserSignListFilter : FilterBase
    {
        /// <summary>
        /// 关联类型
        /// </summary>
        public String MasterType { get; set; }

        /// <summary>
        /// 关联编号
        /// </summary>
        public String MasterId { get; set; }

        /// <summary>
        /// 用户编号
        /// </summary>
        public String UserId { get; set; }

        /// <summary>
        /// 日期
        /// </summary>
        public String SignDate { get; set; }
    }
}
