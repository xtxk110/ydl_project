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
    /// 保存集训班实际课程(如果是第一次操作, 会用集训班课程模板创建实际课程)
    /// </summary>
    public class SaveBootcampCourse_189 : IServiceBase
    {

        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<CoachCourse>>(request);
            Response rsp = ResultHelper.CreateResponse();
            var obj = req.FirstEntity();

            //获取课程信息
            var coachCourse = GetCoachCourse(obj);
            if (coachCourse == null)
            {
                //如果不存在, 说明是首次通过集训模板课程创建实际课程的情况, 那就去创建一个实际课程
                coachCourse = CreateActualCoachCourse(obj);
            }
            obj.Id = coachCourse.Id;//补全Id
            
            //删除之前的学员列表并返还次数
            DeleteOldStudentList(obj);
            //如果学员列表为空就删除此课程
            if (obj.CoursePersonInfoList.Count == 0)
            {
                return DeleteCoachCourse(obj);
            }
            //保存新的学员列表
            foreach (var personInfo in obj.CoursePersonInfoList)
            {
                personInfo.CourseId = obj.Id;
                User user = UserHelper.GetUserById(personInfo.YdlUserId);
                personInfo.StudentName = UserHelper.GetUserName(user);
                personInfo.StudentMobile = user.Mobile;
                //插入一个学员
                SystemHelper.Instance.InsertEntity(personInfo);
                //扣除一次学员的集训余额
                CoachHelper.Instance.SubBootcampBalanceOne(personInfo.YdlUserId, obj.CoachBootcampId);
            }
            rsp.Tag = obj.Id;
            return rsp;

        }



        /// <summary>
        /// 删除之前的学员列表并返还次数
        /// </summary>
        /// <param name="coachCourse"></param>
        public void DeleteOldStudentList(CoachCourse coachCourse)
        {
            List<CoachCoursePersonInfo> list = CoachHelper.Instance.GetCoachCoursePersonInfoList(coachCourse.Id);
            foreach (var item in list)
            {
                //返还此学员的集训课余额 一次
                CoachHelper.Instance.AddBootcampBalanceOne(item.YdlUserId, coachCourse.CoachBootcampId);
                //然后再删除
                List<EntityBase> entites = new List<EntityBase>();
                entites.Add(item);
                item.RowState = RowState.Deleted;
                var result = DbContext.GetInstance().Execute(CommandHelper.CreateSave(entites));
                SystemHelper.CheckResponseIfError(result);
            }
        }

        /// <summary>
        /// 如果不存在就添加此课程
        /// </summary>
        public CoachCourse CreateActualCoachCourse(CoachCourse obj)
        {
            var bootcamp = CoachHelper.Instance.GetCoachBootcampById(obj.CoachBootcampId);
            obj.VenueId = bootcamp.VenueId;
            obj.Type = CoachDic.BootcampCourse;
            obj.State = CoachDic.CourseNotStart;
            obj.RowState = RowState.Added;
            obj.CityId = CoachDic.DefaultCityId;
            obj.TrySetNewEntity();
            List<EntityBase> entites = new List<EntityBase>();
            entites.Add(obj);
            var result = DbContext.GetInstance().Execute(CommandHelper.CreateSave(entites));
            SystemHelper.CheckResponseIfError(result);
            return obj;
        }

        /// <summary>
        /// 获取此教练课程信息, 如果不存在就创建此课程
        /// </summary>
        /// <param name="obj"></param>
        public CoachCourse GetCoachCourse(CoachCourse obj)
        {
            string sql = @"
 SELECT * 
 FROM dbo.CoachCourse
 WHERE CoachBootcampId=@CoachBootcampId
		AND BeginTime=@BeginTime 
		AND EndTime=@EndTime
        AND CoachId=@CoachId
	";
            var cmd = CommandHelper.CreateText<CoachCourse>(FetchType.Fetch, sql);
            cmd.Params.Add("@CoachBootcampId", obj.CoachBootcampId);
            cmd.Params.Add("@BeginTime", obj.BeginTime);
            cmd.Params.Add("@EndTime", obj.EndTime);
            cmd.Params.Add("@CoachId", obj.CoachId);


            var result = DbContext.GetInstance().Execute(cmd);
            var dbCourse = result.FirstEntity<CoachCourse>();
            return dbCourse;
        }



        /// <summary>
        /// 删除此课程
        /// </summary>
        /// <param name="obj"></param>
        public Response DeleteCoachCourse(CoachCourse obj)
        {
            string sql = @"
  
 DELETE FROM dbo.CoachCourse
 WHERE CoachBootcampId=@CoachBootcampId
		AND BeginTime=@BeginTime 
		AND EndTime=@EndTime
	";
            var cmd = CommandHelper.CreateText<CoachCourse>(FetchType.Execute, sql);
            cmd.Params.Add("@CoachBootcampId", obj.CoachBootcampId);
            cmd.Params.Add("@BeginTime", obj.BeginTime);
            cmd.Params.Add("@EndTime", obj.EndTime);

            var result = DbContext.GetInstance().Execute(cmd);
            return result;
        }




    }
}
