using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    /// <summary>
    /// 腾讯IM 接口消息返回格式
    /// </summary>
    public class IMMessageResult
    {
        public IMMessageResult()
        {
            ShuttedUinList = new List<IMGroupMember>();
        }
        /// <summary>
        /// “OK”表示成功，“FAIL”表示失败。
        /// </summary>
        public string ActionStatus { get; set; }
        public string ErrorInfo { get; set; }
        public int ErrorCode { get; set; }

        /// <summary>
        /// 群组中被禁言的用户列表
        /// </summary>
        public List<IMGroupMember> ShuttedUinList { get; set; }

    }
}
