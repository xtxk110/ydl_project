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
    /// 好友
    /// </summary>
    [Table]
    public class UserFriend : EntityBase
    {
        /// <summary>
        /// 用户
        /// </summary>

        [Field]
        public string UserId { get; set; }

        /// <summary>
        /// 好友
        /// </summary>

        [Field]
        public string FriendId { get; set; }

        /// <summary>
        /// 备注
        /// </summary>

        [Field]
        public string Remark { get; set; }
    }
}
