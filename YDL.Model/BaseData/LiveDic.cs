using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    /// <summary>
    /// 直播的 字典数据
    /// </summary>
    public class LiveDic
    {
        #region 直播状态
        public static string UnActive = "UnActive"; //等待开播
        public static string Active = "Active"; //正在直播
        public static string Close = "Close"; //直播已结束
        #endregion 直播状态
    }
}
