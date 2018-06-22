using System;
using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Core;
using YDL.Utility;
using System.Collections.Generic;

namespace YDL.BLL
{
    /// <summary>
    /// 获取开始时间列表
    /// </summary>
    public class GetBeginTimeList_187 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetCoachRelatedFilter>>(request);
            //获取有课的时间列表
            var sql = @"
 SELECT 
	BeginTime
FROM dbo.CoachCourse
WHERE State!='Finished'
	AND ReservedPersonId=@ReservedPersonId
	AND BeginTime>@BeginTime 
	AND EndTime<@EndTime

";
            var cmd = CommandHelper.CreateText<CourseTime>(FetchType.Fetch, sql);
            cmd.Params.Add("@ReservedPersonId", req.Filter.CurrentUserId);
            var BeginTime = Convert.ToDateTime(req.Filter.SyllabusTime.ToShortDateString());
            var EndTime = BeginTime.AddDays(1).AddMinutes(-1);
            cmd.Params.Add("@BeginTime", BeginTime);
            cmd.Params.Add("@EndTime", EndTime);
            var result = DbContext.GetInstance().Execute(cmd);

            var startTimeStr = req.Filter.SyllabusTime.ToString("yyyy-MM-dd ") + "07:00:00";
            var startTime = Convert.ToDateTime(startTimeStr);
            List<CourseTime> list = new List<CourseTime>();
            var haveCourseList = result.Entities.ToList<EntityBase, CourseTime>();
            //构造这一天的开始时间列表, 并把有课的标记出来
            for (int i = 8; i < 22; i++)//约课开始时间范围 08-21点
            {
                CourseTime courseTime = new CourseTime();
                startTime = startTime.AddHours(1);
                var beginTime = (DateTime?)startTime;
                courseTime.BeginTime = beginTime;
                var obj = haveCourseList.Where(e => e.BeginTime == beginTime).FirstOrDefault();
                if (obj != null)
                {
                    courseTime.IsHaveCourse = true;
                }
                list.Add(courseTime);
            }

            //只能约当前时间四个小时后的课
            var timePoint = DateTime.Now.AddHours(4);
            foreach (var item in list)
            {
                if (item.BeginTime < timePoint)
                {
                    item.IsHaveCourse = true;//置灰不能选择
                }
            }

            result.Entities.Clear();
            result.Entities.AddRange(list);
            return result;
        }


    }
}
