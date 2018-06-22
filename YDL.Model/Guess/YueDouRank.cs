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
    /// 悦豆排名
    /// </summary>
    [Table]
    public class YueDouRank : HeadBase
    {
        /// <summary>
        /// 排名
        /// </summary>
        [Field(IsUpdate =false)]
        public long RankNumber { get; set; }


        [Field]
        public string UserName { get; set; }


        [Field]
        public string UserId { get; set; }

        /// <summary>
        /// 赚得的悦豆
        /// </summary>
        [Field]
        public int Amount { get; set; }





    }
}
