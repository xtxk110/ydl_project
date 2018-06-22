using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    public class GetUserScoreHistoryListFilter : FilterBase
    {
        /// <summary>
        /// 用户编号
        /// </summary>
        public string UserId { get; set; }

        /// <summary>
        /// 运动类型
        /// </summary>
        public string SportId { get; set; }
    }
}
