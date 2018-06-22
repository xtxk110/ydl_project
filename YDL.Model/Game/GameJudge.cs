using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using YDL.Core;

namespace YDL.Model
{
    /// <summary>
    /// 比赛裁判表
    /// </summary>
    [Table]
    public class GameJudge : EntityBase
    {
        /// <summary>
        /// 比赛编号
        /// </summary>
        [Field]
        public string GameId { get; set; }

        /// <summary>
        /// 裁判编号
        /// </summary>
        [Field]
        public string UserId { get; set; }

        /// <summary>
        /// 裁判头像
        /// </summary>
        [Field(isUpdate:false)]
        public string HeadUrl { get; set; }

        // <summary>
        /// 裁判手机
        /// </summary>
        [Field(isUpdate:false)]
        public string Mobile { get; set; }
    }
}
