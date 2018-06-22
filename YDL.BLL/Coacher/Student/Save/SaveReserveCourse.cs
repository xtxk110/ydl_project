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
    /// 发表约课(包含大课私教)(仅用于添加操作)
    /// </summary>
    public class SaveReserveCourse_186 : IServiceBase
    {

        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<CoachCourse>>(request);
            var obj = req.FirstEntity();
            string errorMsg;

            #region 默认参数设置
            if (obj.Type == CoachDic.BigCourse)
            {
                obj.BigCourseId = obj.CourseNameId;
            }
            if (obj.Type == CoachDic.PrivateCourse)
            {
                obj.CoachId = obj.CourseNameId;
            }
            #endregion 默认参数设置

            //私教判断是否和请求冲突
            if (obj.Type == CoachDic.PrivateCourse)
            {
                bool isRepeat = IsRepeatTimeInCoachLeave(obj);
                if (isRepeat)
                {
                    return ResultHelper.Fail("教练这个时间段请假了不能约课");
                }
            }

            //大课随机分配空闲教练
            if (obj.Type == CoachDic.BigCourse)
            {
                obj.CourseGrade = 1;
                var randomCoachId = GetRandomFreeCoach(obj);//随机空闲教练Id
                if (string.IsNullOrEmpty(randomCoachId))
                {
                    return ResultHelper.Fail("现在没有空闲的教练来上课, 请换个时间段预约");
                }
                obj.CoachId = randomCoachId;
 
            }

            #region 判断是否有余额
            if (obj.Type == CoachDic.BigCourse)//判断大课是否有余额
            {
                if (HaveBalanceInBigCourse(obj.CourseNameId, obj.ReservedPersonId) == false)
                {
                    return ResultHelper.Fail("余额次数不足, 请购买课程");
                }
            }
            if (obj.Type == CoachDic.PrivateCourse)//判断私教是否有余额
            {
                if (HaveBalanceInPrivateCourse(obj.CourseNameId, obj.ReservedPersonId) == false)
                {
                    return ResultHelper.Fail("余额次数不足, 请购买课程");
                }
            }

            #endregion 判断是否有余额

            //判断时间是否有效 
            errorMsg = CoachHelper.Instance.CheckTimeValid(obj.BeginTime, obj.EndTime);
            if (errorMsg != "")
            {
                return ResultHelper.Fail(errorMsg);
            }

            //私教判断课程时间范围是否和已有的重合
            if (!string.IsNullOrEmpty(obj.CoachId))//有教练Id时
            {
                if (IsRepeatPeriodInPrivateCoach(obj))
                {
                    return ResultHelper.Fail("教练这个时间段有课, 请修改时间范围再约 ");
                }
            }

            #region 设置要添加的数据
            List<EntityBase> entites = new List<EntityBase>();
            entites.Add(obj);

            if (obj.RowState == RowState.Added)
            {
                if (string.IsNullOrEmpty(obj.CoachId))
                {
                    obj.CoachId = "";
                }

                obj.State = CoachDic.CourseNotStart;
                string venueCityId = GetVenueCityId(obj.VenueId);
                if (!string.IsNullOrEmpty(venueCityId))
                {
                    obj.CityId = venueCityId;
                }

                obj.CoachBootcampCourseId = "";
                obj.CreatorId = currentUser.Id;
                obj.TrySetNewEntity();
            }
            #endregion 设置要添加的数据

            //获取将要保存的图片列表
            obj.GetWillSaveFileList(entites);
            var result = DbContext.GetInstance().Execute(CommandHelper.CreateSave(entites));
            if (result.IsSuccess == true)
            {
                //保存个人信息
                result = SaveCoursePersonInfoList(obj);
            }

            //扣除余额
            if (result.IsSuccess == true)
            {
                foreach (var item in obj.CoursePersonInfoList)
                {
                    //有好多人头就扣除好多次
                    result = CoachHelper.Instance.SubOne(obj);
                    if (result.IsSuccess == false)
                    {
                        break;
                    }
                }
            }

            if (result.IsSuccess == true)
            {
                //极光推送
                SendJG(obj.ReservedPersonId, obj.CoachId, obj.Id);
                //发送短信
                qcloudsms_csharp.SmsSingleSenderResult smsResult = SmsHelper.SendCourseSms(currentUser,obj, CoursePersonType.Coacher, CourseSmsType.Save);//发给教练
                qcloudsms_csharp.SmsSingleSenderResult smsResult1 = SmsHelper.SendCourseSms(currentUser,obj, CoursePersonType.Student, CourseSmsType.Save);//发给学生
            }

            return result;

        }
     

        public void SendJG(string reserveId, string coachId, string courseId)
        {

            try
            {
                var user = UserHelper.GetUserById(reserveId);
                var studentName = UserHelper.GetUserName(user);
                Dictionary<string, object> extras = new Dictionary<string, object>();
                extras.Add("Type", SystemMessageType.CoachReservedCourseDetail);
                extras.Add("BusinessId", courseId);
                extras.Add("Message", string.Format("[{0}]学员预约了你的课程, 请查看", studentName));

                JPushHelper.SendCourseSystemMessage(extras, coachId);

            }
            catch (Exception)
            {
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

        public Response SaveCoursePersonInfoList(CoachCourse obj)
        {
            Response rsp = new Response();
            List<EntityBase> entites = new List<EntityBase>();
            foreach (CoachCoursePersonInfo item in obj.CoursePersonInfoList)
            {
                item.CourseId = obj.Id;
                item.IsSignIn = false;
                //检测此学员是否有悦动力账户
                if (!string.IsNullOrEmpty(item.StudentMobile))
                {
                    var ydlUser = UserHelper.GetUserByMobile(item.StudentMobile);//通过手机号反查悦动力账户
                    if (ydlUser != null)
                    {
                        item.YdlUserId = ydlUser.Id;//此学员在悦动力有账户, 保存其id , 方便后续关联
                    }
                }
                item.RowState = RowState.Added;
                item.TrySetNewEntity();
                entites.Add(item);
            }
            if (entites.Count > 0)
            {
                rsp = DbContext.GetInstance().Execute(CommandHelper.CreateSave(entites));
            }
            return rsp;
        }

        public bool HaveBalanceInBigCourse(string BigCourseInfoId, string StudentId)
        {
            string sql = "";
            sql = @"
 SELECT 
	ISNULL(SUM(Amount),0) AS Amount
 FROM dbo.CoachStudentMoney 
 WHERE BigCourseInfoId=@BigCourseInfoId AND StudentUserId=@StudentUserId
 AND Deadline>GETDATE()
 
";

            var cmd = CommandHelper.CreateText<CoachStudentMoney>(FetchType.Fetch, sql);
            cmd.Params.Add("@BigCourseInfoId", BigCourseInfoId);
            cmd.Params.Add("@StudentUserId", StudentId);
            var result = DbContext.GetInstance().Execute(cmd);
            var money = result.FirstEntity<CoachStudentMoney>();

            if (money == null) //没余额记录可扣
            {
                return false;
            }

            if (money.Amount > 0) //有余额可以扣
            {
                return true;
            }
            else // 余额次数用完了
            {
                return false;
            }

        }

        public bool HaveBalanceInPrivateCourse(string CoachId, string StudentId)
        {
            string sql = "";
            sql = @"
  SELECT 
	ISNULL(SUM(Amount),0) AS Amount
 FROM dbo.CoachStudentMoney 
 WHERE CoachId=@CoachId AND StudentUserId=@StudentUserId
 AND Deadline>GETDATE()
";

            var cmd = CommandHelper.CreateText<CoachStudentMoney>(FetchType.Fetch, sql);
            cmd.Params.Add("@CoachId", CoachId);
            cmd.Params.Add("@StudentUserId", StudentId);
            var result = DbContext.GetInstance().Execute(cmd);
            var money = result.FirstEntity<CoachStudentMoney>();

            if (money == null) //没余额记录可扣
            {
                return false;
            }

            if (money.Amount > 0) //有余额可以扣
            {
                return true;
            }
            else // 余额次数用完了
            {
                return false;
            }

        }

        /// <summary>
        /// 获取一个空闲的教练
        /// </summary>
        /// <returns></returns>
        public string GetRandomFreeCoach(CoachCourse obj)
        {
            string coachId = "";
            //先从此教学点 常驻教练中抽取, 这样距离更近
            coachId = GetFreeCoachByVenue(obj);
            if (string.IsNullOrEmpty(coachId))
            {
                //如果此教学点, 没有常驻教练, 就从教练池中抽取
                coachId = GetFreeCoachInPool(obj);
            }
            return coachId;
        }

        /// <summary>
        /// 随机抽取一个常驻此教学点的教练(空闲的)来上大课
        /// </summary>
        /// <returns></returns>
        public string GetFreeCoachByVenue(CoachCourse obj)
        {
            var sql = @"
SELECT 
	a.CoacherId AS Id
FROM dbo.CoachTeachingPointCoaches a
WHERE a.VenueId=@VenueId
	AND a.CoacherId NOT IN(
--获取没空的教练列表
--具体逻辑: 根据学员期望上课的时间段(比如9点到10点)来获取和已有排课有冲突的记录, 从而得到(9点到10点)没有空的教练列表
SELECT 
    CoachId
FROM dbo.CoachCourse 
WHERE   @BeginTime < EndTime AND BeginTime < @EndTime
         AND State!=@State
UNION ALL
SELECT 
    CoachId
FROM dbo.CoachLeave 
WHERE   @BeginTime < EndTime AND BeginTime < @EndTime
        AND  State='010002'
)
";
            var cmd = CommandHelper.CreateText<Coach>(FetchType.Fetch, sql);
            cmd.Params.Add("@VenueId", obj.VenueId);
            cmd.Params.Add("@BeginTime", obj.BeginTime);
            cmd.Params.Add("@EndTime", obj.EndTime);
            cmd.Params.Add("@State", CoachDic.CourseFinished);
            var result = DbContext.GetInstance().Execute(cmd);
            if (result.Entities.Count > 0)
            {
                var list = result.Entities.ToList<EntityBase, Coach>();//空闲教练列表
                Random random = new Random();
                int randomNumber = random.Next(list.Count); //随机抽取一个
                return list[randomNumber].Id;
            }

            return "";
        }


        /// <summary>
        /// 从空闲的教练池中随机抽取一个空闲教练上大课
        /// </summary>
        /// <returns></returns>
        public string GetFreeCoachInPool(CoachCourse obj)
        {
            var sql = @"

 SELECT 
	a.Id 
FROM dbo.Coach a
WHERE 1=1
	AND a.Id NOT IN(
--获取没空的教练列表
--具体逻辑: 根据学员期望上课的时间段(比如9点到10点)来获取和已有排课有冲突的记录, 从而得到(9点到10点)没有空的教练列表
SELECT 
    CoachId
FROM dbo.CoachCourse 
WHERE   @BeginTime < EndTime AND BeginTime < @EndTime
         AND State!=@State
UNION ALL
SELECT 
    CoachId
FROM dbo.CoachLeave 
WHERE   @BeginTime < EndTime AND BeginTime < @EndTime
        AND  State='010002'

)
";
            var cmd = CommandHelper.CreateText<Coach>(FetchType.Fetch, sql);
            cmd.Params.Add("@BeginTime", obj.BeginTime);
            cmd.Params.Add("@EndTime", obj.EndTime);
            cmd.Params.Add("@State", CoachDic.CourseFinished);
            var result = DbContext.GetInstance().Execute(cmd);
            if (result.Entities.Count > 0)
            {
                var list = result.Entities.ToList<EntityBase, Coach>();//空闲教练列表
                Random random = new Random();
                int randomNumber = random.Next(list.Count); //随机抽取一个
                return list[randomNumber].Id;
            }

            return "";
        }

        /// <summary>
        /// 判断课程时间范围是否和请假重合
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
        public bool IsRepeatTimeInCoachLeave(CoachCourse obj)
        {
            //此算法来源于 SO 的牛b算法, 当时本人写了几百行代码都没解决, SO 大神一句就搞定了, 膜拜
            //http://stackoverflow.com/questions/13513932/algorithm-to-detect-overlapping-periods

            var sql = @"
SELECT 
    COUNT(*) 
FROM dbo.CoachLeave 
WHERE   @BeginTime < EndTime AND BeginTime < @EndTime
        AND CoachId=@CoachId AND State='010002'
";

            var cmdVal = CommandHelper.CreateText<ClubUser>(FetchType.Scalar, sql);
            cmdVal.Params.Add("@BeginTime", obj.BeginTime);
            cmdVal.Params.Add("@EndTime", obj.EndTime);
            cmdVal.Params.Add("@CoachId", obj.CoachId);
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
