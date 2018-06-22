using NLog;
using NLog.Config;
using NLog.Layouts;
using NLog.Targets;
using System;
using System.Threading;
using System.Threading.Tasks;

namespace YDL.Utility
{
    public class LoggerHelper
    {
        public static Logger operateLog;
        public static Logger testLog;

        public static Logger GetTestLog()
        {
            if (testLog == null)
            {
                testLog = new LoggerHelper().CreateNLog(LogType.TestLog);
            }

            return testLog;
        }


        public static Logger GetOperateLog()
        {
            if (operateLog == null)
            {
                operateLog = new LoggerHelper().CreateNLog(LogType.OperateLog);
            }

            return operateLog;
        }

        /// <summary>
        /// 创建 NLog
        /// </summary>
        public Logger CreateNLog(string logName)
        {
            var config = new LoggingConfiguration();
            var fileTarget = new FileTarget();
            config.AddTarget(logName, fileTarget);
            //存放路径
            fileTarget.FileName = AppDomain.CurrentDomain.SetupInformation.ApplicationBase+@"log\" + logName + ".json";//"${basedir}/log/" + logName + ".json";
            //布局(日志格式)JSON
            //var jsonLayout = new JsonLayout
            //{
            //    Attributes =
            //    {
            //        new JsonAttribute("time", "${longdate}"),
            //        new JsonAttribute("level", "${level:upperCase=true}"),
            //        new JsonAttribute("message", "${message:withException=true}")
            //    }
            //};

            //布局-字符串格式
            var layout = @"${longdate} ${level:uppercase=true} -- ${message:withException=true}";
            fileTarget.Layout = layout;
            //zip 压缩
            //fileTarget.MaxArchiveFiles = 10;
            //fileTarget.ArchiveFileName = logName + ".zip";
            //fileTarget.ArchiveAboveSize = 1024 * 1024 * 50;// 50mb 打包  ,单位是 Byte
            //fileTarget.EnableArchiveFileCompression = true; //zip 压缩
            //fileTarget.ArchiveNumbering = ArchiveNumberingMode.Sequence;//最大number号是最新文件

            //记录级别 (如: 记录Info 以上级别的日志)
            var rule = new LoggingRule("*", LogLevel.Trace, fileTarget);
            config.LoggingRules.Add(rule);

            //创建日志对象
            LogManager.Configuration = config;
            return LogManager.GetLogger(logName);

        }
    }

    public class LogType
    {
        public readonly static string ExceptionLog = "ExceptionLog";
        public readonly static string OperateLog = "OperateLog";
        public readonly static string TestLog = "TestLog";

    }
}
