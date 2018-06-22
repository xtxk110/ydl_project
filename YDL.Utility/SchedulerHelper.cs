using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Timers;

namespace YDL.Utility
{
    public class SchedulerHelper
    {
        public static void AutoExecuteJob(ElapsedEventHandler job, int day, int hour, int minute, int second)
        {
            Timer timer = new Timer();
            timer.Interval = new TimeSpan(day, hour, minute, second).TotalMilliseconds;
            timer.AutoReset = true;
            timer.Enabled = true;

            timer.Elapsed += new ElapsedEventHandler(job);
        }
    }
}
