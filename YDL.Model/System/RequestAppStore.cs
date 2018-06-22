using YDL.Core;

namespace YDL.Model
{
    /// <summary>
    /// 请求苹果商城审核
    /// </summary>
    public class RequestAppStore : EntityBase
    {
        /// <summary>
        /// 当前版本
        /// </summary>
        public string Version { get; set; }

        /// <summary>
        /// 接口地址
        /// </summary>
        public string Ip { get; set; }
    }
}
