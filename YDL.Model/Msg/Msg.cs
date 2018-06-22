using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using YDL.Core;

namespace YDL.Model
{
    /// <summary>
    /// 消息记录列表
    /// </summary>
    [Table]
    public class Msg : EntityBase
    {
        /// <summary>
        /// 消息类型
        /// </summary>
        [Field]
        public string MasterType { get; set; }

        /// <summary>
        /// 消息关联Id
        /// </summary>
        [Field]
        public string MasterId { get; set; }

        /// <summary>
        /// 标题
        /// </summary>
        [Field]
        public string Title { get; set; }

        /// <summary>
        /// 内容
        /// </summary>
        [Field]
        public string Content { get; set; }

        /// <summary>
        /// 附加数据
        /// </summary>
        [Field]
        public string Data { get; set; }

        /// <summary>
        /// 发送者类型
        /// </summary>
        [Field]
        public string SenderType { get; set; }

        /// <summary>
        /// 发送者编号
        /// </summary>
        [Field]
        public string SenderId { get; set; }

        /// <summary>
        /// 接收者类型
        /// </summary>
        [Field]
        public string ReceiverType { get; set; }

        /// <summary>
        /// 接收者编号
        /// </summary>
        [Field]
        public string ReceiverId { get; set; }

        /// <summary>
        /// 已读状态
        /// </summary>
        [Field(dataType:DataType.Boolean)]
        public bool IsRead { get; set; }
    }
}
