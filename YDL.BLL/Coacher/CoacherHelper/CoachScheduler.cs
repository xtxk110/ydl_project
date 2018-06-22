using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Timers;
using YDL.Map;
using YDL.Model;

namespace YDL.BLL
{
    public class CoachScheduler
    {

        public static CoachScheduler Instance = new CoachScheduler();

        /// <summary>
        /// 提前一个小时提醒教练和学员去上课
        /// </summary>
        public void RemindGoToClass()
        {
            Timer timer = new Timer();
            timer.Interval = new TimeSpan(0, 0, 1, 0).TotalMilliseconds;
            timer.AutoReset = true;
            timer.Enabled = true;

            //每隔1 分钟 触发执行Timer_Elapsed 方法
            timer.Elapsed += new ElapsedEventHandler(Timer_Elapsed);
        }


        /// <summary>
        /// 提前一个小时提醒教练和学员去上课
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public void Timer_Elapsed(object sender, ElapsedEventArgs e)
        {
            //获取合法的记录, 即距离当前时间一个小时后要上课的记录
            var sql = @"
SELECT * FROM (
	SELECT
		Id,
		CoachId,
		ReservedPersonId,  
		differenceMinute= DATEDIFF(MINUTE, @currentTime, BeginTime) 
	FROM dbo.CoachCourse
	WHERE BeginTime>@currentTime 
        AND State !='Finished'
 ) a
 WHERE  a.differenceMinute=60
";
            var cmd = CommandHelper.CreateText<CoachCourse>(FetchType.Fetch, sql);
            cmd.Params.Add("@currentTime", DateTime.Now);
            var result = DbContext.GetInstance().Execute(cmd);
            foreach (var item in result.Entities)
            {
                CoachCourse obj = item as CoachCourse;
                try
                {
                    //发给教练
                    string message = string.Format("注意: 一个小时后你有课要上, 点击查看");
                    Dictionary<string, object> extrasToCoach = new Dictionary<string, object>();
                    extrasToCoach.Add("Type", SystemMessageType.CoachReservedCourseDetail);
                    extrasToCoach.Add("BusinessId", obj.Id);
                    extrasToCoach.Add("Message", message);
                    JPushHelper.SendCourseSystemMessage(extrasToCoach, obj.CoachId);
                    //发给学员
                    Dictionary<string, object> extrasToStudent = new Dictionary<string, object>();
                    extrasToStudent.Add("Type", SystemMessageType.StudentReservedCourseDetail);
                    extrasToStudent.Add("BusinessId", obj.Id);
                    extrasToStudent.Add("Message", message);
                    JPushHelper.SendCourseSystemMessage(extrasToStudent, obj.ReservedPersonId);
                }
                catch (Exception)
                {

                }


            }
        }


    }
}
