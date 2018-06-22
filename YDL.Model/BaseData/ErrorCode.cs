using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    /// <summary>
    /// 错误码定义
    /// </summary>
    public class ErrorCode
    {
        /// <summary>
        /// 服务器正在维护
        /// </summary>
        public static readonly int SERVER_MAINTAIN = 8;

        /// <summary>
        /// 发现新版本
        /// </summary>
        public static readonly int NEW_VERSION = 9;

        /// <summary>
        /// 用户掉线
        /// </summary>
        public static readonly int OFFLINE = 10;

        /// <summary>
        /// 数据不存在
        /// </summary>
        public static readonly int DATA_NOTEXIST = 11;

        /// <summary>
        /// 学员没有余额
        /// </summary>
        public static readonly int STUDENT_NOTBALANCE = 12;

        /// <summary>
        /// 城市暂无价格-教练模块
        /// </summary>
        public static readonly int CITY_NOPRICE_COACH = 13;

        /// <summary>
        ///教练已停用
        /// </summary>
        public static readonly int COACH_DISABLED = 14;

        /// <summary>
        ///悦豆不足
        /// </summary>
        public static readonly int YUEDOU_INSUFFICIENT = 15;

        /// <summary>
        /// 没有传Token
        /// </summary>
        public static readonly int NOT_PASS_TOKEN = 16;
    }
}
