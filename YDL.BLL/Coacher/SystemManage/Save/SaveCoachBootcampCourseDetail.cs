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
    /// 保存集训课的上课详情(记录这节课哪些教练和学员上了)(包含添加和修改操作)
    /// </summary>
    public class SaveCoachBootcampCourseDetail : IServiceBase
    {

        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<CoachCourse>>(request);
            var obj = req.FirstEntity();
            string errorMsg;
            string venueCityId = GetVenueCityId(obj.VenueId);

            //判断时间是否有效 
            errorMsg = CoachHelper.Instance.CheckTimeValid(obj.BeginTime, obj.EndTime);
            if (errorMsg != "")
            {
                return ResultHelper.Fail(errorMsg);
            }

            //添加
            List<EntityBase> entites = new List<EntityBase>();
            entites.Add(obj);
            obj.State = CoachDic.CourseJoin;
            if (!string.IsNullOrEmpty(venueCityId))
            {
                obj.CityId = venueCityId;
            }
            else
            {
                return ResultHelper.Fail("场馆的城市Id为空, 不能保存课程");
            }

            if (obj.RowState == RowState.Added)
            {
                if (string.IsNullOrEmpty(obj.CoachId))
                {
                    obj.CoachId = "";
                }

                obj.TrySetNewEntity();
            }

            obj.CreatorId = currentUser.Id;
            //获取将要保存的图片列表
            obj.GetWillSaveFileList(entites);

            var result = DbContext.GetInstance().Execute(CommandHelper.CreateSave(entites));
            if (result.IsSuccess == true)
            {
                if (obj.RowState == RowState.Modified)
                {
                    //如果是修改操作就先删除后插入
                    deleteCourseJoin(obj.Id);
                }

                result = InsertCoachCourseJoin(obj.StudentList, obj.CoachId, obj.Id);

                //开始极光推送
                Jpush(obj);
            }

            return result;

        }

        private void Jpush(CoachCourse obj)
        {
            try
            {
                string msg = "您有新的集训课安排 , 注意查看";
                //给教练推送
                JPushHelper.SendNotify(MasterType.COACH.Id,
                    obj.Id, msg, new List<string>() { obj.CoachId });
                //给学员推送
                var studentList = new List<string>();
                foreach (var item in obj.StudentList)
                {
                    studentList.Add(item.UserId);
                }
                JPushHelper.SendNotify(MasterType.COACH.Id,
                    obj.Id, msg, studentList);
            }
            catch (Exception)
            {
            }
        }

        public Response deleteCourseJoin(string courseId)
        {
            var sql = @"DELETE FROM dbo.CoachCourseJoin WHERE CourseId=@CourseId ";
            var cmd = CommandHelper.CreateText<ClubUser>(FetchType.Execute, sql);
            cmd.Params.Add("@CourseId", courseId);

            var result = DbContext.GetInstance().Execute(cmd);
            return result;
        }

        public string GetVenueCityId(string venueId)
        {

            var sql = @"
 SELECT CityId FROM dbo.Venue WHERE Id=@Id
";
            var cmd = CommandHelper.CreateText<Venue>(FetchType.Fetch, sql);
            cmd.Params.Add("Id", venueId);
            var result = DbContext.GetInstance().Execute(cmd);
            var venue = result.FirstEntity<Venue>();
            if (venue != null)
            {
                return venue.CityId;
            }
            else
            {
                return "";
            }
        }

        public Response InsertCoachCourseJoin(List<CoachStudent> studentList, string coachId, string CourseId)
        {
            List<EntityBase> entites = new List<EntityBase>();

            foreach (var item in studentList)
            {
                CoachCourseJoin obj = new CoachCourseJoin();
                obj.RowState = RowState.Added;
                obj.TrySetNewEntity();
                obj.StudentId = item.UserId;
                obj.CourseId = CourseId;
                obj.CoachId = coachId;
                obj.ThenCourseUnitPrice = 0;
                entites.Add(obj);
            }

            return DbContext.GetInstance().Execute(CommandHelper.CreateSave(entites));
        }
    }
}
