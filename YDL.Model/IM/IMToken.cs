using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Core;

namespace YDL.Model
{
    /// <summary>
    /// IM接口访问Token对象(里面的部分值来源于腾讯IM平台,我的账户里面)
    /// </summary>
    public class IMToken : EntityBase
    {
        /// <summary>
        /// 签名
        /// </summary>
        public string UserSig { get; set; }
        /// <summary>
        /// Identifier 配的是Admin , 表示权限最高, 可以解散群啊什么的
        /// </summary>
        public string Identifier { get; set; }
        /// <summary>
        /// app ID
        /// </summary>
        public string Sdkappid { get; set; }
        /// <summary>
        /// 账户类型
        /// </summary>
        public string AccountType { get; set; }
    }
}
