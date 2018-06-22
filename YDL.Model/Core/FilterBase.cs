
using YDL.Core;

namespace YDL.Model
{
    /// <summary>
    /// 分页基类
    /// </summary>
    public class FilterBase : EntityBase
    {
        /// <summary>
        /// 页码
        /// </summary>
        public int PageIndex { get; set; }

        /// <summary>
        /// 页大小
        /// </summary>
        public int PageSize { get; set; }

        /// <summary>
        /// 当前登陆者Id
        /// </summary>
        public string CurrentUserId { get; set; }
    }
}
