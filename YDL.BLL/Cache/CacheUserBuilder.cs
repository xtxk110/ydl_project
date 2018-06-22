using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.BLL
{
    /// <summary>
    /// 访问用户缓存账号
    /// </summary>
    public class CacheUserBuilder
    {
        /// <summary>
        /// 用户账号缓存实例
        /// </summary>
        public static readonly ICacheUser Instance = new CacheUserByDb();
    }
}
