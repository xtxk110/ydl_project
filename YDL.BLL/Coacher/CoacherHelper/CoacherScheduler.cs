using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Timers;
using YDL.Map;
using YDL.Utility;

namespace YDL.BLL
{
    public class CoacherScheduler
    {

        public static void AutoCoacherSignOut()
        {
            //每三分钟执行哈教练自动签退
            //SchedulerHelper.AutoExecuteJob(CoacherSignOut, 0, 0, 3, 0);
        }



        /// <summary>
        /// 教练自动签退
        /// </summary>
        public static void CoacherSignOut(object sender, ElapsedEventArgs e)
        {
            //将符自动签退时间小于当前时间的记录都删除
            var sql = @"DELETE FROM dbo.VenueSignInOut WHERE SignOutTime <= GETDATE()";
            var cmd = CommandHelper.CreateText(FetchType.Execute, sql);
            var result = DbContext.GetInstance().Execute(cmd);
        }

    }


}
