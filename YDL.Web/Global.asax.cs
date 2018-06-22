using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;
using YDL.BLL;

namespace YDL.Web
{
    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
            CloseBlackScreenLiveSchedule.AutoCloseBlackScreenLive();
            //Scheduler.GenerateUserSig();
            CoachScheduler.Instance.RemindGoToClass();
            CoacherScheduler.AutoCoacherSignOut();
            
        }

        /// <summary>
        /// 全局未处理异常捕获并记录到数据库
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Application_Error(object sender, EventArgs e)
        {
            Exception exception = Server.GetLastError();
            //string errorMsg = "异常信息:{exception.Message};\n堆栈信息:{exception.StackTrace}";
           // LogHelper.SaveLog("", errorMsg);
            Server.ClearError();
        }

        
    }
}
