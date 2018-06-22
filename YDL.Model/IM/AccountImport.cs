using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    /// <summary>
    /// 账号导入
    /// </summary>
    public class AccountImport
    {

        /// <summary>
        /// 用户名，长度不超过 32 字节
        /// </summary>
        public string Identifier { get; set; }
        /// <summary>
        /// 用户昵称
        /// </summary>
        public string Nick { get; set; }
        /// <summary>
        /// FaceUrl
        /// </summary>
        public string FaceUrl { get; set; }
    }
}
