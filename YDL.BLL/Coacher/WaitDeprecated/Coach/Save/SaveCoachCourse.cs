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
    /// 发表课程(包含大课私教)(包含添加和修改操作)
    /// </summary>
    public class SaveCoachCourse : IServiceBase
    {

        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<CoachCourse>>(request);
            var obj = req.FirstEntity();
            string errorMsg;
            string venueCityId = GetVenueCityId(obj.VenueId);
            if (!string.IsNullOrEmpty(obj.CoachId))//有教练Id时
            {
                //判断教练发布的课程是否在他常驻的城市
                if (!CoachIsInResidentCity(venueCityId, obj.CoachId))
                {
                    return ResultHelper.Fail("你发布的课程所在城市, 不是你常驻地址所在城市");
                }
            }

            //判断时间是否有效 
            errorMsg = CoachHelper.Instance.CheckTimeValid(obj.BeginTime, obj.EndTime);
            if (errorMsg != "")
            {
                return ResultHelper.Fail(errorMsg);
            }

            if (!string.IsNullOrEmpty(obj.CoachId))//有教练Id时
            {
                //判断时间范围是否和已有课程时间范围重合
                if (IsRepeatPeriodInPrivateCoach(obj))
                {
                    return ResultHelper.Fail("和其他课程时间已重合, 不能创建课程");
                }
            }

            //添加
            List<EntityBase> entites = new List<EntityBase>();
            entites.Add(obj);

            if (obj.RowState == RowState.Added)
            {
                if (string.IsNullOrEmpty(obj.CoachId))
                {
                    obj.CoachId = "";
                }

                obj.State = CoachDic.CourseJoin;

                if (!string.IsNullOrEmpty(venueCityId))
                {
                    obj.CityId = venueCityId;
                }
                else
                {
                    return ResultHelper.Fail("场馆的城市Id为空, 不能保存课程");
                }
                obj.CoachBootcampCourseId = "";
                obj.CreatorId = currentUser.Id;
                obj.TrySetNewEntity();
            }

            //获取将要保存的图片列表
            obj.GetWillSaveFileList(entites);

            var result = DbContext.GetInstance().Execute(CommandHelper.CreateSave(entites));
            if (result.IsSuccess == true)
            {
                if (obj.IsShare == true)//分享此课程
                {
                    Note note = new Note();
                    note.Content = "点击查看...";
                    note.CourseId = obj.Id;
                    note.RowState = RowState.Added;
                    CoachHelper.Instance.CoacherCourseShare(note, currentUser.Id);
                }
            }
            return result;

        }

        public bool CoachIsInResidentCity(string courseCityId, string CoachId)
        {
            var sql = @"
 SELECT 
	b.CityId 
 FROM dbo.Coach a
 INNER JOIN dbo.Venue b ON a.VenueId=b.Id
 WHERE a.Id=@CoachId
";
            var cmdVal = CommandHelper.CreateText<Venue>(FetchType.Fetch, sql);
            cmdVal.Params.Add("@CoachId", CoachId);
            var result = DbContext.GetInstance().Execute(cmdVal);
            var obj = result.FirstEntity<Venue>();
            var coachCityId = "";
            if (obj != null)
            {
                coachCityId = obj.CityId;
            }

            if (courseCityId == coachCityId)//如果课程的发布城市Id 等于 教练的常驻城市Id
            {
                return true;
            }
            else
            {
                return false;
            }

        }



        public bool IsRepeatInPrivateCoach(CoachCourse obj)
        {
            var sql = @"
SELECT 
    COUNT(*) 
FROM dbo.CoachCourse 
WHERE      (EndTime = @EndTime OR BeginTime = @BeginTime)
        AND CoachId=@CoachId AND State!=@State
";
            if (obj.RowState == RowState.Modified)
            {
                sql += " AND Id!=@Id ";  //如果是修改操作, 把自己(修改记录)剔除掉判断 . 如果是添加操作, 所有记录参与判断
            }
            var cmdVal = CommandHelper.CreateText<ClubUser>(FetchType.Scalar, sql);
            cmdVal.Params.Add("@BeginTime", obj.BeginTime);
            cmdVal.Params.Add("@EndTime", obj.EndTime);
            cmdVal.Params.Add("@CoachId", obj.CoachId);
            cmdVal.Params.Add("@State", CoachDic.CourseFinished);

            if (obj.RowState == RowState.Modified)
            {
                cmdVal.Params.Add("@Id", obj.Id);
            }
            var result = DbContext.GetInstance().Execute(cmdVal);
            if ((int)result.Tag == 1)
            {
                return true;
            }
            else
            {
                return false;
            }

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

        /// <summary>
        /// 判断课程时间范围是否重合
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
        public bool IsRepeatPeriodInPrivateCoach(CoachCourse obj)
        {
            //此算法来源于 SO 的牛b算法, 当时本人写了几百行代码都没解决, SO 大神一句就搞定了, 膜拜
            //http://stackoverflow.com/questions/13513932/algorithm-to-detect-overlapping-periods

            var sql = @"
SELECT 
    COUNT(*) 
FROM dbo.CoachCourse 
WHERE   @BeginTime < EndTime AND BeginTime < @EndTime
        AND CoachId=@CoachId AND State!=@State
";
            if (obj.RowState == RowState.Modified)
            {
                sql += " AND Id!=@Id ";  //如果是修改操作, 把自己(修改记录)剔除掉判断 . 如果是添加操作, 所有记录参与判断
            }
            var cmdVal = CommandHelper.CreateText<ClubUser>(FetchType.Scalar, sql);
            cmdVal.Params.Add("@BeginTime", obj.BeginTime);
            cmdVal.Params.Add("@EndTime", obj.EndTime);
            cmdVal.Params.Add("@CoachId", obj.CoachId);
            cmdVal.Params.Add("@State", CoachDic.CourseFinished);

            if (obj.RowState == RowState.Modified)
            {
                cmdVal.Params.Add("@Id", obj.Id);
            }
            var result = DbContext.GetInstance().Execute(cmdVal);
            if ((int)result.Tag == 1)
            {
                return true;
            }
            else
            {
                return false;
            }

        }

    }
}
