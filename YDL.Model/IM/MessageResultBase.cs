using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    /// <summary>
    /// 返回结果
    /// </summary>
    public class MessageResultBase
    {
        /// <summary>
        /// “OK”表示成功，“FAIL”表示失败。
        /// </summary>
        public string ActionStatus { get; set; }
        public string ErrorInfo { get; set; }
        public int ErrorCode { get; set; }
    }
}
