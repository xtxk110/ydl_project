using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Utility
{
    public static class DateTimeHelper
    {
        public static DateTime FirstDay(int year, int month)
        {
            return new DateTime(year, month, 1);
        }

        public static DateTime LastDay(int year, int month)
        {
            return new DateTime(year, month, DateTime.DaysInMonth(year,month));
        }

        /// <summary>
        /// 转换日期为斜杠形式
        /// </summary>
        /// <param name="dt"></param>
        /// <returns></returns>
        public static string DateToSlash(DateTime dt)
        {
            return dt.ToString("yyyy/MM/dd");
        }
        /// <summary>
        /// 转换日期为直线格式
        /// </summary>
        /// <param name="dt"></param>
        /// <returns></returns>
        public static string DateToLine(DateTime dt)
        {
            return dt.ToString("yyyy-MM-dd");
        }
        /// <summary>
        /// 转换时间为斜杠形式
        /// </summary>
        /// <param name="dt"></param>
        /// <returns></returns>
        public static string DateTimeToSlash(DateTime dt)
        {
            return dt.ToString("yyyy/MM/dd HH:mm:ss");
        }
        /// <summary>
        /// 转换时间为直线形式
        /// </summary>
        /// <param name="dt"></param>
        /// <returns></returns>
        public static string DateTimeToLine(DateTime dt)
        {
            return dt.ToString("yyyy-MM-dd HH:mm:ss");
        }
    }
}
