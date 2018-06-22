using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    /// <summary>
    /// 消息内容详情（不同格式，对应不同信息）
    /// </summary>
    public class MessageContent
    {
        /// <summary>
        /// 
        /// </summary>
        public string Text { get; set; }
        public string Desc { get; set; }
        public decimal Latitude { get; set; }
        public decimal Longitude { get; set; }
        public int Index { get; set; }
        public string Data { get; set; }
        public string Ext { get; set; }
        public string Sound { get; set; }
    }
}
