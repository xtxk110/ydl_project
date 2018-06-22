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
    /// 获取集训的课程列表
    /// </summary>
    public class GetCoachBootcampCourseList : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetSystemManageRelatedFilter>>(request);
            var cmd = CommandHelper.CreateProcedure<CoachBootcampCourse>(text: "sp_GetCoachBootcampCourseList");
            cmd.Params.Add(CommandHelper.CreateParam("@CoachBootcampId", req.Filter.CoachBootcampId));
            cmd.Params.Add(CommandHelper.CreateParam("@CurrentUserId", req.Filter.CurrentUserId));
            if (req.Filter.BootcampCourseBeginTime != DateTime.MinValue && req.Filter.BootcampCourseEndTime != DateTime.MinValue)
            {
                //前端传了用前端的时间
                cmd.Params.Add(CommandHelper.CreateParam("@BeginTime", req.Filter.BootcampCourseBeginTime));
                cmd.Params.Add(CommandHelper.CreateParam("@EndTime", req.Filter.BootcampCourseEndTime.AddDays(1).AddMinutes(-1)));

            }
            else //没传走以下逻辑
            {

                //如果当前时间在 课程表时间范围内, 课程表列表从当前时间开始查询
                SetBeginEndTime(cmd, req.Filter.CoachBootcampId);
            }


            cmd.CreateParamPager(req.Filter);

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();
            result = ComputeState(result, req.Filter.CoachBootcampId, req.Filter.CurrentUserId);
            foreach (var item in result.Entities)
            {
                CoachBootcampCourse obj = item as CoachBootcampCourse;
                obj.AppointmentCount = GetAppointmentCount(obj.Id);
            }
            List<CoachBootcampSyllabus> listSyllabus = new List<CoachBootcampSyllabus>();
            //先得到日期列表
            var listCourse = result.Entities.ToList<EntityBase, CoachBootcampCourse>();
            List<DateTime> listDate = listCourse
                .GroupBy(e => ((DateTime)e.BeginTime).Date)
                .Select(g => (DateTime)g.First().BeginTime)
                .ToList();
            //再根据日期得到每个节点数据
            List<CoachBootcampCourse> coachBootcampCourseList = new List<CoachBootcampCourse>();
            foreach (var item in listDate)
            {
                var listCourseSecond = listCourse.Where(e =>
                    ((DateTime)e.BeginTime).ToShortDateString() == item.ToShortDateString()
                );
                CoachBootcampSyllabus syllabus = new CoachBootcampSyllabus();
                syllabus.Date = item;
                syllabus.DayOfWeek = Helper.GetDayOfWeekChinese(item.DayOfWeek.ToString());
                foreach (var second in listCourseSecond)
                {
                    //syllabus.CourseList.Add(second);
                    coachBootcampCourseList.Add(second);
                }

                //listSyllabus.Add(syllabus);
            }

            result.Entities.Clear();
            result.Entities.AddRange(coachBootcampCourseList);
            return result;

        }

        public int GetAppointmentCount(string BootcampCourseId)
        {
            string sql = @"
SELECT 
    COUNT(Id) AS AppointmentCount
FROM dbo.CoachBootcampCourseJoin 
WHERE BootcampCourseId=@BootcampCourseId
";
            var cmd = CommandHelper.CreateText<CoachBootcampCourse>(FetchType.Fetch, sql);
            cmd.Params.Add("@BootcampCourseId", BootcampCourseId);
            var result = DbContext.GetInstance().Execute(cmd);
            var obj = result.FirstEntity<CoachBootcampCourse>();
            if (obj != null)
            {
                return obj.AppointmentCount;
            }
            else
            {
                return 0;
            }

        }


        /// <summary>
        /// 计算课程和学员教练相关的各种状态
        /// </summary>
        public Response ComputeState(Response result, string CoachBootcampId, string CurrentUserId)
        {
            //学员如果没有报名(没有买集训课)
            if (!CoachHelper.Instance.IsJoinedCoachBootcamp(CoachBootcampId, CurrentUserId))
            {
                foreach (var item in result.Entities)
                {
                    CoachBootcampCourse obj = item as CoachBootcampCourse;
                    obj.State = "NotBuy";
                }
            }
            else //有买集训课, 计算其他状态
            {
                foreach (var item in result.Entities)
                {//遍历每节课
                    CoachBootcampCourse obj = item as CoachBootcampCourse;
                    if (CoachHelper.Instance.IsHaveCourse(CurrentUserId, obj.Id))
                    {
                        //有课
                        obj.State = "HaveCourse";
                    }
                    else //没有课, 判断其他状态
                    {
                        if (IsAppointmentBootcampCourse(obj.Id, CurrentUserId))
                        {
                            //预约成功
                            obj.State = "Joined";
                        }
                        else
                        {
                            //未预约
                            obj.State = "NotJoin";
                        }
                    }

                }//遍历每节课

            } //有买集训课, 计算其他状态


            return result;
        }

        public bool IsAppointmentBootcampCourse(string BootcampCourseId, string StudentId)
        {
            string sql = @"
SELECT * 
FROM dbo.CoachBootcampCourseJoin 
WHERE StudentId=@StudentId 
        AND BootcampCourseId=@BootcampCourseId
";
            var cmd = CommandHelper.CreateText<Coacher>(FetchType.Fetch, sql);
            cmd.Params.Add("@StudentId", StudentId);
            cmd.Params.Add("@BootcampCourseId", BootcampCourseId);

            var result = DbContext.GetInstance().Execute(cmd);
            if (result.Entities.Count > 0)
            {
                return true;
            }
            else
            {
                return false;
            }

        }

        public void SetBeginEndTime(Command cmdTop, string CoachBootcampId)
        {
            string sql = @"
 SELECT 
	MIN(BeginTime) AS BeginTime,
	MAX(EndTime) AS EndTime 
 FROM dbo.CoachBootcampCourse
  WHERE CoachBootcampId=@CoachBootcampId


";
            var cmd = CommandHelper.CreateText<CoachBootcampCourse>(FetchType.Fetch, sql);
            cmd.Params.Add("@CoachBootcampId", CoachBootcampId);
            var result = DbContext.GetInstance().Execute(cmd);
            var obj = result.FirstEntity<CoachBootcampCourse>();
            var minBeginTime = obj.BeginTime;
            var maxEndTime = obj.EndTime;
            //如果当前时间在 课程表时间范围内, 课程表列表从当前时间开始查询 ,并将后面的数据都查询出来
            if (minBeginTime <= DateTime.Now && DateTime.Now <= maxEndTime)
            {
                cmd.Params.Add(CommandHelper.CreateParam("@BeginTime", DateTime.Now));
                cmd.Params.Add(CommandHelper.CreateParam("@EndTime", DateTime.MaxValue));
            }

        }

        


    }

}
