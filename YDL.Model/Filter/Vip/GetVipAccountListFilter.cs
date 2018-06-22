using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    /// <summary>
    /// GetVipAccountListFilter
    /// </summary>
    public class GetVipAccountListFilter : FilterBase
    {
        /// <summary>
        /// 用户编号
        /// </summary>
        public String UserName { get; set; }
    }
}
