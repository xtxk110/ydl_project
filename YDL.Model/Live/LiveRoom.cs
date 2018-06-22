using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Core;
using YDL.Utility;

namespace YDL.Model
{
    /// <summary>
    /// 直播房间
    /// </summary>
    [Table]
    public class LiveRoom : HeadBase
    {
        /// <summary>
        /// 直播标题
        /// </summary>
        [Field]
        public string LiveTitle { get; set; }

        /// <summary>
        /// 主播id
        /// </summary>
        [Field]
        public string AnchorId { get; set; }

        /// <summary>
        /// 直播状态
        /// </summary>
        [Field]
        public string State { get; set; }

        /// <summary>
        /// 比赛id
        /// </summary>
        [Field]
        public string GameId { get; set; }

        /// <summary>
        /// 对阵OrderId
        /// </summary>
        [Field]
        public string VsOrderId { get; set; }

        /// <summary>
        /// 对阵GameLoopId
        /// </summary>
        [Field]
        public string VsGameLoopId { get; set; }
        /// <summary>
        /// 断流计数
        /// </summary>
        [Field]
        public int NotPushCount { get; set; }

        public GuessVS VSDetail { get; set; }

        /// <summary>
        /// 播放Url
        /// </summary>
        public string PlayUrl { get; set; }

        /// <summary>
        /// 推流Url
        /// </summary>
        public string PushUrl { get; set; }

        /// <summary>
        /// 是否使用的第三方直播设备
        /// </summary>
        [Field(dataType: DataType.Boolean)]
        public bool IsThirdparty { get; set; }
        /// <summary>
        /// 直播分享地址(m3u8格式,通用但延迟较大)
        /// </summary>
        public string SharePlayUrl { get; set; }
        /// <summary>
        /// 是否是点播,true点播
        /// </summary>
        [Field(dataType:DataType.Boolean)]
        public bool IsVod { get; set; }
        /// <summary>
        /// 视频点播地址
        /// </summary>
        [Field]
        public string VodPlayUrl { get; set; }
    }
}
