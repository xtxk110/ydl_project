using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using YDL.Utility;

namespace YDL.Map
{
    /// <summary>
    /// 服务请求
    /// </summary>
    public class Request
    {
        /// <summary>
        /// 用户编号
        /// </summary>
        public String UserId { get; set; }

        /// <summary>
        /// TOKEN
        /// </summary>
        public String Token { get; set; }

        /// <summary>
        /// 是否移动端
        /// </summary>
        public bool IsMobile { get; set; }

        /// <summary>
        /// 是否加密
        /// </summary>
        public bool IsEncrypt { get; set; }

        /// <summary>
        /// 是否内部测试
        /// </summary>
        public bool IsInnerTest { get; set; }

        public object Tag { get; set; }
    }

    /// <summary>
    /// 服务请求，带集合实体
    /// </summary>
    public class Request<T> : Request
    {
        /// <summary>
        /// 过滤条件
        /// </summary>
        public T Filter { get; set; }

        /// <summary>
        /// 实体列表
        /// </summary>
        public List<T> Entities { get; set; }

        public T FirstEntity()
        {
            return Entities.FirstOrDefault();
        }
    }

}
