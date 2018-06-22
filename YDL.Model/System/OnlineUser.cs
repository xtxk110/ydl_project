using System;
using YDL.Core;

namespace YDL.Model
{
    /// <summary>
    /// 持久化在线用户
    /// </summary>
    [Table]
    public class OnlineUser : EntityBase
    {
        /// <summary>
        /// 用户
        /// </summary>
        [Field]
        public string UserId { get; set; }

        /// <summary>
        /// 在线Token，登录成功分配给客户端
        /// </summary>
        [Field]
        public string Token { get; set; }

        /// <summary>
        /// 设备类型
        /// </summary>
        [Field]
        public string DeviceType { get; set; }
    }
}
