using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Utility
{
    public class Helper
    {
        /// <summary>
        /// 国际IEEE 四舍六入
        /// </summary>
        /// <param name="number"></param>
        /// <param name="digits"></param>
        /// <returns></returns>
        public static decimal GetRoundOffByIEEE(decimal number, int digits)
        {
            return Math.Round(number, digits);
        }

        /// <summary>
        /// 中国式 四舍五入
        /// </summary>
        /// <param name="number"></param>
        /// <param name="decimalPlaces"></param>
        /// <returns></returns>
        public static decimal GetRoundOffByChina(decimal number, int decimalPlaces)
        {
            return Math.Round(number, decimalPlaces, MidpointRounding.AwayFromZero);
        }

        /// <summary>
        /// 米转千米
        /// </summary>
        /// <param name="M"></param>
        /// <returns></returns>
        public static decimal ConvertMToKM(int M )
        {
            return M/1000;
        }

        public static string GetDayOfWeekChinese(string day)
        {
            switch (day)
            {
                case "Sunday":
                    return "星期天";
                case "Monday":
                    return "星期一";
                case "Tuesday":
                    return "星期二";
                case "Wednesday":
                    return "星期三";
                case "Thursday":
                    return "星期四";
                case "Friday":
                    return "星期五";
                case "Saturday":
                    return "星期六";
                default:
                    return "";
            }
        }
    }
}
