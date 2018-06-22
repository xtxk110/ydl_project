using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    /// <summary>
    /// 获取用户权限列表条件
    /// </summary>
    public class GetUserLimitListFilter : FilterBase
    {
        /// <summary>
        /// 单独查找用户编号
        /// </summary>
        public string UserId { get; set; }

        /// <summary>
        /// 权限申请处理状态
        /// </summary>
        public string IsProcessed { get; set; }
    }
}
