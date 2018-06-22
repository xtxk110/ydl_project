using System;
using System.Linq;
using System.Collections.Generic;

using Newtonsoft.Json;
using YDL.Utility;
using YDL.Map;
using YDL.Model;
using YDL.Core;

namespace YDL.BLL
{
    public static class LogHelper
    {
        /// <summary>
        /// 创建日志对象，不保存。(done)
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="title"></param>
        /// <param name="sourceId"></param>
        /// <returns></returns>
        public static SysLog CreateLog(String userId, String title, String sourceId = null)
        {
            var log = new SysLog();
            log.SetNewEntity();
            log.CreatorId = userId;
            log.SourceId = sourceId;
            log.Title = title;
            log.CreateDate = DateTime.Now;
            return log;
        }

        //创建并保存日志对象。
        public static void SaveLog(String userId, String title, String sourceId = null)
        {
            var log = CreateLog(userId, title, sourceId);
            SaveLog(log);
        }

        private static void SaveLog(SysLog log)
        {
            try
            {
                DbContext.GetInstance().Execute(CommandHelper.CreateSave(new List<EntityBase> { log }));
            }
            catch (Exception e)
            {
            }
        }
    }


}
