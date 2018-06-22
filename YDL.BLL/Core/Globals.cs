using System;
using System.Text;
using System.Linq;
using System.Collections.Generic;
using System.Configuration;

using Newtonsoft.Json;
using YDL.Core;
using YDL.Map;
using YDL.Model;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 工具类
    /// </summary>
    public static class Globals
    {
        /// <summary>
        /// 悦动力二维码前缀
        /// </summary>
        public static readonly string YDL_QRCODE_PREFIX = "CDYDLCORP";
        /// <summary>
        /// 系统默认帐号Id
        /// </summary>
        public static readonly string ADMIN_ID = "0E01F871-41E5-4EFF-977E-B058EF8275C0";
        public static readonly List<string> ADMIN_ID_LIST = new List<string> { "001001", "001002" };

        /// <summary>
        /// 乒乓球一局比分
        /// </summary>
        public static readonly int TT_ONE_GAME_FEN = 11;

        /// <summary>
        /// 乒乓球胜积2分
        /// </summary>
        public static readonly int TT_SCORE_WIN = 2;

        /// <summary>
        /// 乒乓球负积1分
        /// </summary>
        public static readonly int TT_SCORE_FAIL = 1;

        /// <summary>
        /// 乒乓球弃权积0分
        /// </summary>
        public static readonly int TT_SCORE_WAIVER = 0;

        /// <summary>
        /// 服务器维护KEY
        /// </summary>
        public static string APP_KEY_IS_SERVER_MAINTAIN = "IsServerMaintain";

        /// <summary>
        /// 服务器维护说明KEY
        /// </summary>
        public static string APP_KEY_MAINTAIN_TIME = "MaintainTime";

        /// <summary>
        /// 正在提交苹果商城审核的版本KEY
        /// </summary>
        public static string APP_KEY_REQUEST_APPSTORE_VER = "RequestAppStoreVer";

        /// <summary>
        /// 提交苹果商城的新版本对应的接口地址KEY
        /// </summary>
        public static string APP_KEY_REQUEST_APPSTORE_IP = "RequestAppStoreIp";

        /// <summary>
        /// 管理员编号KEY
        /// </summary>
        public static string APP_KEY_ADMIN_ID_LIST = "AdminIdList";

        /// <summary>
        /// 插入不存在的城市
        /// </summary>
        /// <param name="cityCode"></param>
        /// <param name="cityName"></param>
        public static void SaveCity(string cityCode, string cityName)
        {
            try
            {
                var cmd = CommandHelper.CreateProcedure(FetchType.Execute, "sp_SaveCity");
                cmd.Params.Add(CommandHelper.CreateParam("@cityCode", cityCode));
                cmd.Params.Add(CommandHelper.CreateParam("@cityName", cityName));

                DbContext.GetInstance().Execute(cmd);
            }
            catch (Exception)
            {
            }

        }

        /// <summary>
        /// 四舍五入
        /// </summary>
        /// <param name="value"></param>
        /// <param name="scale"></param>
        /// <returns></returns>
        public static double Round(double value, int scale)
        {
            var strValue = value.ToString();
            return Convert.ToDouble(strValue.Substring(0, strValue.IndexOf(Constant.Str_Point) + scale));
        }

        /// <summary>
        /// 获取服务器维护状态
        /// </summary>
        /// <returns></returns>
        public static bool IsMaintain()
        {
            return GetAppSettings(APP_KEY_IS_SERVER_MAINTAIN) == "1";
        }

        /// <summary>
        /// 获取服务器维护状态
        /// </summary>
        /// <returns></returns>
        public static bool IsAdministrator(string userId)
        {
            var value = GetAppSettings(APP_KEY_ADMIN_ID_LIST);
            if (value.IsNotNullOrEmpty())
            {
                return value.IndexOf(userId) > -1;
            }
            return false;
        }

        /// <summary>
        /// 是否正在请求苹果商城审核的版本
        /// </summary>
        /// <returns></returns>
        public static bool IsRequestAppStoreVer(string version)
        {
            return GetAppSettings(APP_KEY_REQUEST_APPSTORE_VER) == version;
        }

        /// <summary>
        /// 请求苹果商城审核的版本对应接口IP
        /// </summary>
        /// <returns></returns>
        public static string RequestAppStoreIP()
        {
            return GetAppSettings(APP_KEY_REQUEST_APPSTORE_IP);
        }

        /// <summary>
        /// 获取配置信息
        /// </summary>
        /// <param name="key"></param>
        /// <returns></returns>
        public static string GetAppSettings(string key)
        {
            if (ConfigurationManager.AppSettings.AllKeys.Contains(key))
            {
                return ConfigurationManager.AppSettings[key];
            }
            return null;
        }
    }
}
