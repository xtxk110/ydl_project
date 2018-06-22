using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    /// <summary>
    /// 消息内容（包括消息类型）
    /// </summary>
    public class MessageBody
    {
        /// <summary>
        /// 
        /// </summary>
        public string MsgType { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public MessageContent MsgContent { get; set; }
    }
}
