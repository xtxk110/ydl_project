using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    /// <summary>
    /// 用户有哪些角色
    /// </summary>
    public class UserRole
    {
        /// <summary>
        /// 是否为教练
        /// </summary>
        public bool IsCoach { get; set; }

        /// <summary>
        /// 是否为普通用户
        /// </summary>
        public bool IsGeneralUser { get; set; }

    }
}
