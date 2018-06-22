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
    /// 公共配置
    /// </summary>
    [Table]
    public class Config : EntityBase
    {
        /// <summary>
        /// 公司支付宝
        /// </summary>
        [Field]
        public string AliPayId { get; set; }

        /// <summary>
        /// 俱乐部每次活动积分
        /// </summary>
        [Field(dataType: DataType.Int32)]
        public int ActivityScore { get; set; }

        /// <summary>
        /// 技能初始积分
        /// </summary>
        [Field(dataType: DataType.Int32)]
        public int SkillScore { get; set; }

        /// <summary>
        /// 技能初始积分
        /// </summary>
        [Field(dataType: DataType.Double)]
        public double RefundDiscount { get; set; }

        /// <summary>
        /// 是否服务器维护
        /// </summary>
        [Field(dataType: DataType.Boolean)]
        public bool IsMainTain { get; set; }

        /// <summary>
        /// 服务器维护提示
        /// </summary>
        [Field]
        public string MainTainTip { get; set; }

        /// <summary>
        /// 服务器维护提示
        /// </summary>
        [Field]
        public int BigCourseValidDays { get; set; }

        /// <summary>
        /// 悦豆兑换比例
        /// </summary>
        [Field]
        public int YueDouConvertibleProportion { get; set; }

        /// <summary>
        ///竞猜手续费
        /// </summary>
        [Field]
        public decimal GuessServiceCharge { get; set; }

        /// <summary>
        ///赛事TV 广域网 Socket服务器的Ip和端口(任何地方都可以访问)
        /// </summary>
        [Field]
        public string SocketIpAndPort { get; set; }

        /// <summary>
        ///赛事TV 局域网内 HTTP服务器的Ip和端口(仅局域网可以访问)
        /// </summary>
        [Field]
        public string IntranetHttpIpAndPort { get; set; }
        /// <summary>
        ///赛事TV 局域网内 Socket服务器的Ip和端口(仅局域网可以访问)
        /// </summary>
        [Field]
        public string IntranetSocketIpAndPort { get; set; }
    }
}
