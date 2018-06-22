using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    /// <summary>
    /// 消息格式
    /// </summary>
    public static class MessageType
    {
        /// <summary>
        /// 文本消息
        /// </summary>
        public const string TIMTextElem = "TIMTextElem";
        /// <summary>
        /// 地理位置
        /// </summary>
        public const string TIMLocationElem = "TIMLocationElem";
        /// <summary>
        /// 表情
        /// </summary>
        public const string TIMFaceElem = "TIMFaceElem";
        /// <summary>
        /// 自定义消息
        /// </summary>
        public const string TIMCustomElem = "TIMCustomElem";

        /*******************以下三种格式，服务端不支持，仅在客户端支持*********************/
        /// <summary>
        /// 语音
        /// </summary>
        public const string TIMSoundElem = "TIMSoundElem";
        /// <summary>
        /// 图像
        /// </summary>
        public const string TIMImageElem = "TIMImageElem";
        /// <summary>
        /// 文件
        /// </summary>
        public const string TIMFileElem = "TIMFileElem";
    }
}
