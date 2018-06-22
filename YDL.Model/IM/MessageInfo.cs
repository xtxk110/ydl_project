using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    /// <summary>
    /// IM消息
    /// </summary>
    public class MessageInfo
    {

        public MessageInfo()
        {
            MsgBody = new List<MessageBody>();
        }
        /// <summary>
        /// 1:把消息同步到From_Account在线发送终端上
        /// </summary>
        public int SyncOtherMachine { get; set; }
        /// <summary>
        /// 消息发送方，为空即为系统消息
        /// </summary>
        public string From_Account { get; set; }
        /// <summary>
        /// 消息接收方
        /// </summary>
        public string To_Account { get; set; }
        /// <summary>
        /// 消息随机数，由随机函数产生。（用作消息去重）
        /// </summary>
        public int MsgRandom { get; set; }
        /// <summary>
        /// 消息时间戳，unix时间戳
        /// </summary>
        public int MsgTimeStamp { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public List<MessageBody> MsgBody { get; set; }
    }
}
