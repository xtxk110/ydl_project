using Newtonsoft.Json;
using YDL.Map;
using YDL.Core;
using YDL.Model;
using System.Linq;
using System.Collections.Generic;
using YDL.Utility;
using System;

namespace YDL.BLL
{
    public class CoachHelper
    {
        public static CoachHelper Instance = new CoachHelper();
        public static decimal GetCoursePrice(string GradeId, string CourseTypeId)
        {
            var sql = @"SELECT *  FROM dbo.CoacherPrice WHERE 1=1 ";
            sql += " AND GradeId=@gradeId AND CourseTypeId=@CourseTypeId ";
            var cmd = CommandHelper.CreateText<CoacherPrice>(FetchType.Fetch, sql);
            cmd.Params.Add("@gradeId", GradeId);
            cmd.Params.Add("@CourseTypeId", CourseTypeId);
            var result = DbContext.GetInstance().Execute(cmd);
            var obj = result.FirstEntity<CoacherPrice>();

            if (obj.CourseTypeId == Model.CoachDic.BigCourse
                      || obj.CourseTypeId == Model.CoachDic.SmallCourse
                      || obj.CourseTypeId == Model.CoachDic.PrivateCourse)
            {
                obj.CoursePrice = obj.CoursePrice * 10;//10节课 起卖
            }
            return obj.CoursePrice;
        }

        #region 获取课程学员列表

        public static List<CoachStudent> GetStudentList(string courseId)
        {

            var sql = @"
SELECT 
     b.Id,
     b.Id AS UserId,
     b.HeadUrl,
     b.CardName AS Name,
     b.Sex,
     a.CoachId,
	 c.Remark,
     a.ThenCourseUnitPrice
 FROM dbo.CoachCourseJoin a
 INNER JOIN dbo.UserAccount b ON a.StudentId=b.Id
 LEFT JOIN dbo.CoachStudentRemark c ON a.StudentId=c.StudentId AND a.CourseId=c.CourseId
 WHERE a.CourseId=@courseId

";
            var cmd = CommandHelper.CreateText<CoachStudent>(FetchType.Fetch, sql);
            cmd.Params.Add("@courseId", courseId);
            var result = DbContext.GetInstance().Execute(cmd);
            return result.Entities.ToList<EntityBase, CoachStudent>() ?? new List<CoachStudent>();
        }

        public static int CountEmptyPosition(int FillPosition, string courseType)
        {
            switch (courseType)
            {
                case "027001"://大课
                    return CoachDic.BigCourseMaxPerson - FillPosition;
                case "027002"://小课
                    return 3 - FillPosition;
                case "027003"://私教
                    return 1 - FillPosition;
                case "027004"://体验课
                    return 1 - FillPosition;
                default:
                    return 0;
            }
        }
        #endregion 获取课程学员列表

        #region 课程取消报名

        public Response CourseNotJoin(List<CoachCourseJoin> list)
        {
            Response result = new Response();
            foreach (var item in list)
            {
                // 验证数据是否合法 (都有值才进行后面的操作)
                if (string.IsNullOrEmpty(item.CourseId) || string.IsNullOrEmpty(item.StudentId)
                    || string.IsNullOrEmpty(item.CoachId))
                {
                    continue;
                }


                if (!IsExist(item))//判断取消的课程 是否存在
                {
                    return ResultHelper.Fail("课程已取消, 不能再取消");
                }
                result = DeleteCourseJoin(item);//删除此学员的课程报名 记录

                if (result.IsSuccess)
                {
                    //取消报名, 余额加一次
                    result = AddOne(item);

                }
            }

            return result;
        }


        /// <summary>
        /// 删除此学员的课程报名记录
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
        public Response DeleteCourseJoin(CoachCourseJoin obj)
        {
            var sql = @"
DELETE FROM CoachCourseJoin WHERE CourseId=@CourseId AND StudentId=@StudentUserId

";
            var cmd = CommandHelper.CreateText(FetchType.Execute, sql);
            cmd.Params.Add("@CourseId", obj.CourseId);
            cmd.Params.Add("@StudentUserId", obj.StudentId);

            var result = DbContext.GetInstance().Execute(cmd);
            return result;
        }
        public bool IsExist(CoachCourseJoin obj)
        {
            string sql = "";
            sql = @"
SELECT Id FROM dbo.CoachCourseJoin 
WHERE StudentId=@StudentUserId AND  CourseId=@CourseId 
";
            var cmd = CommandHelper.CreateText<CoachCourse>(FetchType.Fetch, sql);
            cmd.Params.Add("@StudentUserId", obj.StudentId);
            cmd.Params.Add("@CourseId", obj.CourseId);

            var result = DbContext.GetInstance().Execute(cmd);
            if (result == null)
            {
                return false;
            }

            if (result.Entities.Count == 1)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        public Response AddOne(CoachCourseJoin obj)
        {
            var course = CoachHelper.Instance.GetCoachCourseById(obj.CourseId);
            var cmd = CommandHelper.CreateProcedure<CoacherApply>(text: "sp_SaveCoachCourseJoin");
            cmd.Params.Add(CommandHelper.CreateParam("@StudentUserId", obj.StudentId));
            cmd.Params.Add(CommandHelper.CreateParam("@CoacherUserId", obj.CoachId));
            cmd.Params.Add(CommandHelper.CreateParam("@CourseId", obj.CourseId));
            cmd.Params.Add(CommandHelper.CreateParam("@CityId", course.CityId));
            cmd.Params.Add(CommandHelper.CreateParam("@ThenCourseUnitPrice", 0, DataType.Decimal, ParamDirection.Output));
            cmd.Params.Add(CommandHelper.CreateParam("@Type", "NotJoin"));//取消报名

            cmd.CreateParamMsg();

            var result = DbContext.GetInstance().Execute(cmd);

            return result;
        }
        #endregion 课程取消报名

        /// <summary>
        /// 根据课程Id 获取课程
        /// </summary>
        /// <param name="courseId"></param>
        /// <returns></returns>
        public CoachCourse GetCoacherCourse(string courseId)
        {
            var sql = @"SELECT * FROM dbo.CoachCourse WHERE Id=@CourseId ";
            var cmd = CommandHelper.CreateText<CoachCourse>(FetchType.Fetch, sql);
            cmd.Params.Add("@CourseId", courseId);
            var result = DbContext.GetInstance().Execute(cmd);
            return result.FirstEntity<CoachCourse>();
        }

        /// <summary>
        /// 教练是否签到
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
        public bool IsSignIn(string VenueId, string CoacherUserId)
        {

            string sql = "";
            sql = @"
SELECT * FROM dbo.VenueSignInOut WHERE VenueId =@VenueId AND CoacherUserId=@CoacherUserId
";
            var cmd = CommandHelper.CreateText<Coacher>(FetchType.Fetch, sql);
            cmd.Params.Add("@VenueId", VenueId);
            cmd.Params.Add("@CoacherUserId", CoacherUserId);
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

        /// <summary>
        /// 课程分享
        /// </summary>
        /// <param name="obj"></param>
        /// <param name="userId"></param>
        /// <returns></returns>
        public Response CoacherCourseShare(Note obj, string userId)
        {
            List<EntityBase> entites = new List<EntityBase>();
            entites.Add(obj);

            if (obj.RowState == RowState.Added)
            {
                obj.IsShare = true;
                obj.CreatorId = userId;
                obj.TrySetNewEntity();
            }

            var result = DbContext.GetInstance().Execute(CommandHelper.CreateSave(entites));
            return result;
        }

        #region 获取有效期
        /// <summary>
        /// 获取有效期
        /// </summary>
        /// <param name="CourseTypeId"></param>
        /// <param name="times">倍数(数据库配置1个单位课程的有效期，购买N个单位，即为此有效期的N倍)</param>
        /// <returns></returns>
        public static DateTime GetDeadline(string CourseTypeId, int times)
        {
            if (CourseTypeId == Model.CoachDic.BigCourse)
            {
                var validDays = UserHelper.GetConfig().BigCourseValidDays;
                return DateTime.Now.AddDays(validDays * times);
            }
            else
            {
                return DateTime.MaxValue;
            }
        }

        /// <summary>
        /// 获取有效期
        /// </summary>
        /// <param name="CourseTypeId"></param>
        /// <returns></returns>
        public static DateTime GetDeadlineNotUse(string CourseTypeId, string type,
            string StudentUserId = "", string CoacherUserId = "")
        {
            DateTime deadline = DateTime.Now;
            //大课小课,计算截止日期
            if (CourseTypeId == "027001" || CourseTypeId == "027002")
            {
                var sql = @"SELECT * FROM dbo.CoacherPrice WHERE GradeName='有效期' AND CourseTypeId=@courseTypeId ";
                var cmd = CommandHelper.CreateText<CoacherPrice>(FetchType.Fetch, sql);
                cmd.Params.Add("@courseTypeId", CourseTypeId);
                var result = DbContext.GetInstance().Execute(cmd);
                var days = DbContext.GetInstance().Execute(cmd)
                    .FirstEntity<CoacherPrice>()
                    .CoursePrice;
                //业务逻辑: 目前计算有效期有两种方式, 第一种当前时间添加有效天数,第二种,学员最新余额有效期添加天数
                if (type == "AddCurrent")//第一种当前时间添加有效天数
                {
                    deadline = DateTime.Now.AddDays((double)days);
                }
                else if (type == "AddToLatestDeadline") //第二种,学员最新余额有效期添加天数
                {
                    var money = GetStudentLatestTime(StudentUserId, CoacherUserId, CourseTypeId);
                    if (money == null)
                    {
                        deadline = DateTime.Now.AddDays((double)days);
                    }
                    else
                    {
                        deadline = money.Deadline.AddDays((double)days);
                    }
                }
            }
            //私教课,体验课 加个1000年 让他永不过期 (不可能这课上了一千年还没上完吧 , 呵呵)
            if (CourseTypeId == "027003" || CourseTypeId == "027004")
            {
                deadline = DateTime.Now.AddYears(1000);
            }

            return deadline;
        }

        /// <summary>
        /// 获取此学员最新的余额有限期 (要次数大于零, 没有过期的)
        /// </summary>
        /// <param name="StudentUserId"></param>
        /// <param name="CoacherUserId"></param>
        /// <param name="CourseTypeId"></param>
        /// <returns></returns>
        public static CoachStudentMoney GetStudentLatestTime(string StudentUserId, string CoacherUserId, string CourseTypeId)
        {
            var sql = @"
SELECT  
	TOP 1
    a.*
FROM dbo.CoachStudentMoney a
WHERE  StudentUserId=@StudentUserId AND CoacherUserId=@CoacherUserId
	AND CourseTypeId=@CourseTypeId AND Amount>0 AND Deadline > GETDATE()
ORDER BY Deadline DESC
";
            var cmd = CommandHelper.CreateText<CoachStudentMoney>(FetchType.Fetch, sql);
            cmd.Params.Add("@StudentUserId", StudentUserId);
            cmd.Params.Add("@CoacherUserId", CoacherUserId);
            cmd.Params.Add("@CourseTypeId", CourseTypeId);
            var result = DbContext.GetInstance().Execute(cmd);
            return result.FirstEntity<CoachStudentMoney>();

        }

        #endregion 获取有效期

        /// <summary>
        /// 是否为教练(包括悦动力教练和封闭机构教练)
        /// </summary>
        /// <param name="userId"></param>
        /// <returns></returns>
        public Response GetIsCoacher(string userId)
        {
            var sql = @"
SELECT 
	IsCoacher=CONVERT(BIT,COUNT(Id))  
FROM dbo.Coach WHERE Id=@userId
 ";
            var cmd1 = CommandHelper.CreateText<User>(FetchType.Fetch, sql);
            cmd1.Params.Add("@userId", userId);
            var result1 = DbContext.GetInstance().Execute(cmd1);

            return result1;
        }

        /// <summary>
        /// 是否为教练(包括悦动力教练和封闭机构教练)
        /// </summary>
        /// <param name="userId"></param>
        /// <returns></returns>
        public bool IsCoach(string userId)
        {
            var user = GetIsCoacher(userId).FirstEntity<User>();
            return user.IsCoacher;
        }

        /// <summary>
        /// 是否为悦动力教练(和封闭机构教练区分, 封闭机构教练可以申请成为悦动力教练,搞扯)
        /// </summary>
        /// <param name="userId"></param>
        /// <returns></returns>
        public bool IsYDLCoach(string userId)
        {
            Coach coach = GetCoach(userId);
            if (coach == null)
            {
                return false;
            }
            else if (coach.OrganizationId == "ydl")
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        /// <summary>
        /// 是否为封闭机构教练
        /// </summary>
        /// <param name="userid"></param>
        /// <returns></returns>
        public bool IsSealedCoach(string userid)
        {
            Coach coach = GetCoach(userid);
            if (coach == null)
            {
                return false;
            }
            else if (coach.OrganizationId != "ydl"
                && !string.IsNullOrEmpty(coach.SealedOrganizationId)
                )
            {
                return true;
            }
            else
            {
                return false;
            }

        }

        public bool IsExistCategory(SysDic obj)
        {
            string sql = "";
            sql = @"
SELECT * FROM dbo.SysDic WHERE Type='CategoryOfTechnology' AND Name=@Name
";
            var cmd = CommandHelper.CreateText<SysDic>(FetchType.Fetch, sql);
            cmd.Params.Add("@Name", obj.Name);
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



        public static UserRole GetUserRole(string userId)
        {
            UserRole userRole = new UserRole();
            //是否为教练
            var sql = @"
SELECT 
	Id
FROM dbo.Coach WHERE Id=@userId
 ";
            var cmd = CommandHelper.CreateText<User>(FetchType.Fetch, sql);
            cmd.Params.Add("@userId", userId);
            var result = DbContext.GetInstance().Execute(cmd);
            if (result.Entities.Count > 0)
            {
                userRole.IsCoach = true;
            }
            else
            {
                userRole.IsCoach = false;
            }

            return userRole;
        }

        public Coach GetCoach(string userId)
        {
            var sql = @"
SELECT 
	*
FROM dbo.Coach WHERE Id=@userId
 ";
            var cmd = CommandHelper.CreateText<Coach>(FetchType.Fetch, sql);
            cmd.Params.Add("@userId", userId);
            var result = DbContext.GetInstance().Execute(cmd);
            var obj = result.FirstEntity<Coach>();
            if (obj != null)
            {
                User user = UserHelper.GetUserById(obj.Id);
                if (user != null)
                {
                    obj.Name = UserHelper.GetUserName(user);
                }
            }

            return result.FirstEntity<Coach>();
        }

        public bool IsTeachingPointManager(string userId)
        {
            string sql = @"
SELECT Id FROM dbo.Venue WHERE CourseManagerId=@CourseManagerId
";
            var cmd = CommandHelper.CreateText<Venue>(FetchType.Fetch, sql);
            cmd.Params.Add("@CourseManagerId", userId);
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

        public CoachCourse GetCoachCourseById(string CourseId)
        {
            string sql = "";
            sql = @"
SELECT * FROM dbo.CoachCourse WHERE Id=@Id
";
            var cmd = CommandHelper.CreateText<CoachCourse>(FetchType.Fetch, sql);
            cmd.Params.Add("@Id", CourseId);
            var result = DbContext.GetInstance().Execute(cmd);
            var data = result.FirstEntity<CoachCourse>() ?? new CoachCourse();
            return data;
        }

        //教练是否启用
        public bool CoachIsEnabled(string coachId)
        {
            string sql = @"
SELECT IsEnabled FROM dbo.Coach WHERE Id=@Id
";
            var cmd = CommandHelper.CreateText<Coach>(FetchType.Fetch, sql);
            cmd.Params.Add("@Id", coachId);
            var result = DbContext.GetInstance().Execute(cmd);
            var coach = result.FirstEntity<Coach>();
            if (coach != null && coach.IsEnabled)
            {
                return true;
            }
            else
            {
                return false;
            }

        }

        /// <summary>
        /// 判断教练发表的课程时间是否有效 
        /// </summary>
        /// <param name="beginTime"></param>
        /// <param name="endTime"></param>
        /// <returns></returns>
        public string CheckTimeValid(DateTime? beginTime, DateTime? endTime)
        {
            var beginTimedt = (DateTime)beginTime;
            var endTimedt = (DateTime)endTime;

            var beginTimeMax = Convert.ToDateTime(beginTimedt.ToString("yyyy-MM-dd 21:00:00"));
            var endTimeMax = Convert.ToDateTime(endTimedt.ToString("yyyy-MM-dd 22:00:00"));

            var beginTimeMin = Convert.ToDateTime(beginTimedt.ToString("yyyy-MM-dd 08:00:00"));


            if ((endTimeMax.Day - beginTimeMax.Day) > 0)
            {
                return "课程的时间不能跨天";
            }
            else if (beginTimedt <= DateTime.Now)
            {
                return "课程的开始时间要大于当前时间";
            }
            else if (endTimedt <= beginTimedt)
            {
                return "课程的结束时间要大于开始时间";
            }
            else if (beginTimedt > beginTimeMax)
            {
                return "课程的开始时间不能超过 晚上9点";
            }
            else if (endTimedt > endTimeMax)
            {
                return "课程的结束时间不能超过 晚上10点";
            }
            else if (beginTimedt < beginTimeMin)
            {
                return "课程的开始时间不能小于早上8点";

            }
            else
            {
                return "";
            }
        }


        /// <summary>
        /// 判断集训的课程模板时间是否有效 
        /// </summary>
        /// <param name="beginTime"></param>
        /// <param name="endTime"></param>
        /// <returns></returns>
        public string CheckTimeValidForBootcampCourseTemplate(DateTime? beginTime, DateTime? endTime)
        {
            var beginTimedt = (DateTime)beginTime;
            var endTimedt = (DateTime)endTime;

            var beginTimeMax = Convert.ToDateTime(beginTimedt.ToString("yyyy-MM-dd 21:00:00"));
            var endTimeMax = Convert.ToDateTime(endTimedt.ToString("yyyy-MM-dd 22:00:00"));

            var beginTimeMin = Convert.ToDateTime(beginTimedt.ToString("yyyy-MM-dd 08:00:00"));


            if ((endTimeMax.Day - beginTimeMax.Day) > 0)
            {
                return "课程的时间不能跨天";
            }
            else if (endTimedt <= beginTimedt)
            {
                return "课程的结束时间要大于开始时间";
            }
            else
            {
                return "";
            }
        }


        public bool IsCurrentVenueCourseManager(string userId, string venueId)
        {
            string sql = @"
SELECT Id FROM dbo.Venue WHERE CourseManagerId=@CourseManagerId AND Id=@VenueId
";
            var cmd = CommandHelper.CreateText<Venue>(FetchType.Fetch, sql);
            cmd.Params.Add("@CourseManagerId", userId);
            cmd.Params.Add("@VenueId", venueId);

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

        public User GetVenueCourseManager(string venueId)
        {
            string sql = @"
SELECT b.*
FROM dbo.Venue a
INNER JOIN dbo.UserAccount b ON a.CourseManagerId=b.Id
WHERE  a.Id=@VenueId
";
            var cmd = CommandHelper.CreateText<User>(FetchType.Fetch, sql);
            cmd.Params.Add("@VenueId", venueId);

            var result = DbContext.GetInstance().Execute(cmd);
            return result.FirstEntity<User>();

        }

        public bool IsJoinedCoachBootcamp(string CoachBootcampId, string StudentUserId)
        {
            string sql = @"
SELECT 
    * 
FROM dbo.CoachStudentMoney 
WHERE StudentUserId=@StudentUserId 
AND CoachBootcampId=@CoachBootcampId
";
            var cmd = CommandHelper.CreateText<Coacher>(FetchType.Fetch, sql);
            cmd.Params.Add("@StudentUserId", StudentUserId);
            cmd.Params.Add("@CoachBootcampId", CoachBootcampId);

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

        public bool IsHaveCourse(string CurrentUserId, string CoachBootcampCourseId)
        {
            string sql = @"
SELECT 
    IsHaveCourse=CONVERT(BIT,CASE WHEN COUNT(a.Id) >0 THEN 1 ELSE 0 END)
FROM dbo.CoachCourse a
INNER JOIN dbo.CoachCourseJoin b ON a.Id=b.CourseId
WHERE a.CoachBootcampCourseId=@CoachBootcampCourseId
AND (a.CoachId =@CurrentUserId OR b.StudentId=@CurrentUserId)


";
            var cmd = CommandHelper.CreateText<CoachBootcampCourse>(FetchType.Fetch, sql);
            cmd.Params.Add("@CurrentUserId", CurrentUserId);
            cmd.Params.Add("@CoachBootcampCourseId", CoachBootcampCourseId);

            var result = DbContext.GetInstance().Execute(cmd);
            var obj = result.FirstEntity<CoachBootcampCourse>();
            if (obj != null)
            {
                return obj.IsHaveCourse;
            }
            else
            {
                return false;
            }
        }


        /// <summary>
        /// 根据课程Id获取这个课程的约课人列表
        /// </summary>
        /// <param name="courseId"></param>
        /// <returns></returns>
        public List<CoachCoursePersonInfo> GetCoachCoursePersonInfoList(string courseId)
        {
            string sql = @"
  SELECT 
    a.*,
	c.CourseContent
FROM dbo.CoachCoursePersonInfo a
LEFT JOIN dbo.CoachCourse b ON a.CourseId=b.Id 
LEFT JOIN dbo.CoachBigCourseInfo c ON b.BigCourseId=c.Id
WHERE CourseId=@CourseId 
ORDER BY CreateDate ASC
 ";
            var cmd = CommandHelper.CreateText<CoachCoursePersonInfo>(FetchType.Fetch, sql);
            cmd.Params.Add("@CourseId", courseId);
            var result = DbContext.GetInstance().Execute(cmd);
            return result.Entities.ToList<EntityBase, CoachCoursePersonInfo>();
        }

        public decimal GetCoachUnitPrice(string cityId, int coachGrade)
        {

            var sql = @"
   SELECT * FROM dbo.CoachPrice WHERE CityCode=@CityeCode  
";
            var cmd = CommandHelper.CreateText<CoachPrice>(FetchType.Fetch, sql);
            cmd.Params.Add("@CityeCode", cityId);
            var result = DbContext.GetInstance().Execute(cmd);
            var price = result.FirstEntity<CoachPrice>();
            if (price == null)
                return 0;
            if (coachGrade == 1)
            {
                return price.CGrade;
            }
            else if (coachGrade == 2)
            {
                return price.BGrade;
            }
            else if (coachGrade == 3)
            {
                return price.AGrade;
            }
            else
            {
                return 0;
            }
        }



        public CoachStudentMoney GetBigCourseBalance(string StudentUserId, string BigCourseInfoId)
        {
            var sql = @"
 SELECT 
	SUM(Amount) AS Amount,
	SUM(ThenTotalAmount) AS  ThenTotalAmount
 FROM CoachStudentMoney  
 WHERE StudentUserId=@StudentUserId
	AND BigCourseInfoId=@BigCourseInfoId
	AND Deadline> GETDATE()
";
            var cmd = CommandHelper.CreateText<CoachStudentMoney>(FetchType.Fetch, sql);
            cmd.Params.Add("@StudentUserId", StudentUserId);
            cmd.Params.Add("@BigCourseInfoId", BigCourseInfoId);
            var result = DbContext.GetInstance().Execute(cmd);
            return result.FirstEntity<CoachStudentMoney>();
        }

        public CoachStudentMoney GetPrivateCourseBalance(string StudentUserId, string CoachId)
        {
            var sql = @"
 SELECT 
	SUM(Amount) AS Amount,
	SUM(ThenTotalAmount) AS  ThenTotalAmount
 FROM CoachStudentMoney  
 WHERE StudentUserId=@StudentUserId
	AND CoachId=@CoachId
 
";
            var cmd = CommandHelper.CreateText<CoachStudentMoney>(FetchType.Fetch, sql);
            cmd.Params.Add("@StudentUserId", StudentUserId);
            cmd.Params.Add("@CoachId", CoachId);
            var result = DbContext.GetInstance().Execute(cmd);
            return result.FirstEntity<CoachStudentMoney>();
        }

        /// <summary>
        /// 获取教练对学员的点评信息
        /// </summary>
        /// <param name="CoursePersonInfoId"></param>
        /// <returns></returns>
        public CoachCommentStudent GetStudentCommentDetail(string CoursePersonInfoId)
        {

            var sql = @"
SELECT 
	a.*
FROM dbo.CoachCommentStudent a
WHERE CoursePersonInfoId=@CoursePersonInfoId
";
            var cmd = CommandHelper.CreateText<CoachCommentStudent>(FetchType.Fetch, sql);
            cmd.Params.Add("@CoursePersonInfoId", CoursePersonInfoId);
            var result = DbContext.GetInstance().Execute(cmd);
            var obj = result.FirstEntity<CoachCommentStudent>();
            if (obj != null)
            {
                obj.TryGetFiles();
                //获取技术类别名称
                obj.TeachTypeName = GetTeachTypeNames(obj);
            }
            return obj ?? new CoachCommentStudent();
        }

        public string GetTeachTypeNames(CoachCommentStudent obj)
        {
            if (string.IsNullOrEmpty(obj.TeachTypeId))
            {
                return "";
            }

            string[] ids = obj.TeachTypeId.Split(';');
            string names = "";
            foreach (var item in ids)
            {
                var sysDic = SystemHelper.Instance.GetSysDicById(item);
                if (sysDic != null)
                {
                    names += sysDic.Name + "、";
                }

            }
            names = names.Trim('、');
            return names;
        }

        /// <summary>
        /// 计算课程的状态
        /// </summary>
        /// <param name="coachCourse"></param>
        public void CountCourseState(CoachCourse coachCourse)
        {
            if (coachCourse.State == CoachDic.CourseFinished)
            {
                if (coachCourse.MyScore == 0)
                {
                    coachCourse.CourseState = "NotScore";//未评分
                }
                else if (coachCourse.MyScore > 0)
                {
                    coachCourse.CourseState = "HasScore";//已评分
                }
            }
            else if (coachCourse.State == CoachDic.CourseNotStart || coachCourse.State == CoachDic.CourseProcessing)
            {
                coachCourse.CourseState = "NotStart";//已预约
            }

        }

        public CoachFrequentStudent GetFrequentStudent(string CreatorId, string Mobile, string FrequentStudentId)
        {
            string sql = @"
 SELECT 
    * 
 FROM dbo.CoachFrequentStudent
 WHERE CreatorId=@CreatorId AND Mobile=@Mobile

";
            if (!string.IsNullOrEmpty(FrequentStudentId))
            {
                sql += " AND Id!=@Id"; //修改时剔除自己
            }

            var cmd = CommandHelper.CreateText<CoachFrequentStudent>(FetchType.Fetch, sql);
            cmd.Params.Add("@CreatorId", CreatorId);
            cmd.Params.Add("@Mobile", Mobile);
            cmd.Params.Add("@Id", FrequentStudentId);

            var result = DbContext.GetInstance().Execute(cmd);
            return result.FirstEntity<CoachFrequentStudent>();

        }

        public CoachTrainingPlan GetTrainingPlan(string CoachId, string StudentId)
        {
            var sql = @"
 SELECT * 
 FROM dbo.CoachTrainingPlan 
 WHERE CoachId =@CoachId 
	AND StudentId=@StudentId
";
            var cmd = CommandHelper.CreateText<CoachTrainingPlan>(FetchType.Fetch, sql);
            cmd.Params.Add("@CoachId", CoachId);
            cmd.Params.Add("@StudentId", StudentId);
            var result = DbContext.GetInstance().Execute(cmd);
            return result.FirstEntity<CoachTrainingPlan>();
        }

        public Response SubOne(CoachCourse obj)
        {
            var cmd = CommandHelper.CreateProcedure<CoacherApply>(text: "sp_ReserveCourseAddSubOne");
            cmd.Params.Add(CommandHelper.CreateParam("@StudentUserId", obj.ReservedPersonId));
            cmd.Params.Add(CommandHelper.CreateParam("@CoachId", obj.CourseNameId));
            cmd.Params.Add(CommandHelper.CreateParam("@BigCourseId", obj.CourseNameId));
            cmd.Params.Add(CommandHelper.CreateParam("@CourseTypeId ", obj.Type));
            cmd.Params.Add(CommandHelper.CreateParam("@CityId", "75"));
            cmd.Params.Add(CommandHelper.CreateParam("@Type", "Sub"));
            cmd.CreateParamMsg();

            var result = DbContext.GetInstance().Execute(cmd);

            return result;
        }

        public Response AddOne(CoachCourse obj)
        {
            var cmd = CommandHelper.CreateProcedure<CoacherApply>(text: "sp_ReserveCourseAddSubOne");
            cmd.Params.Add(CommandHelper.CreateParam("@StudentUserId", obj.ReservedPersonId));
            cmd.Params.Add(CommandHelper.CreateParam("@CoachId", obj.CourseNameId));
            cmd.Params.Add(CommandHelper.CreateParam("@BigCourseId", obj.CourseNameId));
            cmd.Params.Add(CommandHelper.CreateParam("@CourseTypeId ", obj.Type));
            cmd.Params.Add(CommandHelper.CreateParam("@CityId", "75"));
            cmd.Params.Add(CommandHelper.CreateParam("@Type", "Add"));
            cmd.CreateParamMsg();

            var result = DbContext.GetInstance().Execute(cmd);

            return result;
        }

        public CoachBigCourseInfo GetBigCourseInfo(string bigcourseId)
        {
            var sql = @"
SELECT  * FROM  dbo.CoachBigCourseInfo WHERE Id=@BigCourseInfoId
";
            var cmd = CommandHelper.CreateText<CoachBigCourseInfo>(FetchType.Fetch, sql);
            cmd.Params.Add("@BigCourseInfoId", bigcourseId);
            var result = DbContext.GetInstance().Execute(cmd);
            return result.FirstEntity<CoachBigCourseInfo>();
        }

        /// <summary>
        /// 根据Id获取集训详情
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public CoachBootcamp GetCoachBootcampById(string bootcampId)
        {
            var sql = @"
SELECT 
	a.* ,
	b.Address AS VenueAddress,
    b.Name AS VenueName
FROM dbo.CoachBootcamp a
LEFT JOIN dbo.Venue b ON a.VenueId=b.Id
WHERE a.Id=@Id

";
            var cmd = CommandHelper.CreateText<CoachBootcamp>(FetchType.Fetch, sql);
            cmd.Params.Add("@Id", bootcampId);
            var result = DbContext.GetInstance().Execute(cmd);
            var obj = result.FirstEntity<CoachBootcamp>();
            return obj;
        }

        /// <summary>
        /// 获取集训课的余额
        /// </summary>
        /// <param name="StudentUserId"></param>
        /// <returns></returns>
        public CoachStudentMoney GetBootcampBalance(string StudentUserId, string CoachBootcampId)
        {
            var sql = @"
 SELECT 
	SUM(Amount) AS Amount,
	SUM(ThenTotalAmount) AS  ThenTotalAmount
 FROM CoachStudentMoney  
 WHERE StudentUserId=@StudentUserId
	AND CoachBootcampId=@CoachBootcampId
	 
";
            var cmd = CommandHelper.CreateText<CoachStudentMoney>(FetchType.Fetch, sql);
            cmd.Params.Add("@StudentUserId", StudentUserId);
            cmd.Params.Add("@CoachBootcampId", CoachBootcampId);
            var result = DbContext.GetInstance().Execute(cmd);
            return result.FirstEntity<CoachStudentMoney>();
        }

        /// <summary>
        /// 获取集训总的余额
        /// </summary>
        /// <param name="StudentUserId"></param>
        /// <returns></returns>
        public CoachStudentMoney GetBootcampAllBalance(string StudentUserId)
        {
            var sql = @"
 SELECT 
	SUM(Amount) AS Amount,
	SUM(ThenTotalAmount) AS  ThenTotalAmount
 FROM CoachStudentMoney  
 WHERE StudentUserId=@StudentUserId
	AND CourseTypeId='027005'
	 
";
            var cmd = CommandHelper.CreateText<CoachStudentMoney>(FetchType.Fetch, sql);
            cmd.Params.Add("@StudentUserId", StudentUserId);
            var result = DbContext.GetInstance().Execute(cmd);
            return result.FirstEntity<CoachStudentMoney>();
        }


        /// <summary>
        /// 获取集训最后一次上课时间
        /// </summary>
        /// <param name="StudentUserId"></param>
        /// <param name="CourseTypeId"></param>
        /// <returns></returns>
        public DateTime? GetLastGoCourseTimeInBootcamp(string StudentUserId, string CourseTypeId)
        {
            var sql = @"
SELECT 
	TOP 1
	a.CreateDate 
 FROM dbo.CoachCourse a
 INNER JOIN dbo.CoachCoursePersonInfo b ON a.Id=b.CourseId
 WHERE  b.YdlUserId=@ReservedPersonId
	AND Type='027005'
ORDER BY a.CreateDate DESC
";
            var cmd = CommandHelper.CreateText<CoachCourse>(FetchType.Fetch, sql);
            cmd.Params.Add("@ReservedPersonId", StudentUserId);
            cmd.Params.Add("@CourseTypeId", CourseTypeId);//暂时没用
            var result = DbContext.GetInstance().Execute(cmd);
            var obj = result.FirstEntity<CoachCourse>();
            if (obj != null)
            {
                return obj.CreateDate;
            }
            return null;
        }


        /// <summary>
        /// 获取最后一次上课时间
        /// </summary>
        /// <param name="StudentUserId"></param>
        /// <param name="CourseTypeId"></param>
        /// <returns></returns>
        public DateTime? GetLastGoCourseTime(string StudentUserId, string CourseTypeId)
        {
            var sql = @"
SELECT 
	TOP 1
	CreateDate 
 FROM dbo.CoachCourse
 WHERE  ReservedPersonId=@ReservedPersonId
	AND Type=@CourseTypeId
ORDER BY CreateDate DESC
";
            var cmd = CommandHelper.CreateText<CoachCourse>(FetchType.Fetch, sql);
            cmd.Params.Add("@ReservedPersonId", StudentUserId);
            cmd.Params.Add("@CourseTypeId", CourseTypeId);
            var result = DbContext.GetInstance().Execute(cmd);
            var obj = result.FirstEntity<CoachCourse>();
            if (obj != null)
            {
                return obj.CreateDate;
            }
            return null;
        }

        /// <summary>
        /// 返还集训课余额一次
        /// </summary>
        /// <param name="StudentUserId"></param>
        /// <returns></returns>
        public void AddBootcampBalanceOne(string StudentUserId, string CoachBootcampId)
        {
            var sql = @"
UPDATE CoachStudentMoney SET Amount=Amount+1
 WHERE StudentUserId=@StudentUserId
	AND CoachBootcampId=@CoachBootcampId
	 
";
            var cmd = CommandHelper.CreateText<ClubUser>(FetchType.Execute, sql);
            cmd.Params.Add("@StudentUserId", StudentUserId);
            cmd.Params.Add("@CoachBootcampId", CoachBootcampId);
            var result = DbContext.GetInstance().Execute(cmd);
            SystemHelper.CheckResponseIfError(result);
        }

        /// <summary>
        /// 扣除集训课余额一次
        /// </summary>
        /// <param name="StudentUserId"></param>
        /// <returns></returns>
        public void SubBootcampBalanceOne(string StudentUserId, string CoachBootcampId)
        {
            var sql = @"
UPDATE CoachStudentMoney SET Amount=Amount-1
 WHERE StudentUserId=@StudentUserId
	AND CoachBootcampId=@CoachBootcampId
";
            var cmd = CommandHelper.CreateText<ClubUser>(FetchType.Execute, sql);
            cmd.Params.Add("@StudentUserId", StudentUserId);
            cmd.Params.Add("@CoachBootcampId", CoachBootcampId);
            var result = DbContext.GetInstance().Execute(cmd);
            SystemHelper.CheckResponseIfError(result);
        }

        /// <summary>
        ///去除重复的集训课程数据
        ///     即: 集训已安排课程(如9点到10点的)和集训模板课程(如9点到10点的)重复,就去除模板数据
        ///      名称解释:
        ///              集训已安排课程 : 指的是已经安排教练和学员的课程
        ///              集训模板课程: 指的是未安排教练和学员的课程, 两者关系是: 用模板来创建 上面的 集训已安排课程
        /// </summary>
        /// <param name="formalCourseList"></param>
        /// <param name="templateCourseList"></param>
        /// <returns></returns>
        public List<CoachCourse> GetFilteredTemplateCourseList(List<CoachCourse> formalCourseList, List<CoachCourse> templateCourseList)
        {
            var filteredTemplateCourseList = new List<CoachCourse>();
            foreach (var item in templateCourseList)
            {
                var templateCourse = formalCourseList.Where(e => e.CoachBootcampId == item.CoachBootcampId
                                    && e.BeginTime == item.BeginTime
                                    && e.EndTime == item.EndTime
                                    ).FirstOrDefault();
                if (templateCourse != null)
                {
                    //说明模板课程已生成正式课程, 故不在尾部显示
                    continue;
                }
                filteredTemplateCourseList.Add(item);
            }
            return filteredTemplateCourseList;
        }

        public CoachBootcampStudent GetBootcampStudentById(string id)
        {

            var sql = @"
SELECT * FROM dbo.CoachBootcampStudent WHERE Id=@Id
";
            var cmd = CommandHelper.CreateText<CoachBootcampStudent>(FetchType.Fetch, sql);
            cmd.Params.Add("@Id", id);
            var result = DbContext.GetInstance().Execute(cmd);
            return result.FirstEntity<CoachBootcampStudent>();
        }


        /// <summary>
        /// 设置课程的评分(平均分)
        /// </summary>
        /// <param name="coachCourse"></param>
        public void SetCourseAvgScore(CoachCourse coachCourse)
        {

            var sql = @"
SELECT 
    ISNULL(AVG(Score),0) AS Score 
FROM dbo.CoachComment 
WHERE 
    CourseId=@CourseId 

";
            var cmd = CommandHelper.CreateText<CoachCourse>(FetchType.Fetch, sql);
            cmd.Params.Add("@CourseId", coachCourse.Id);
            var result = DbContext.GetInstance().Execute(cmd);
            var obj = result.FirstEntity<CoachCourse>();
            coachCourse.Score = Helper.GetRoundOffByChina(obj.Score, 2);
        }

        /// <summary>
        /// 是否为封闭机构学员
        /// </summary>
        /// <param name="studentid"></param>
        /// <returns></returns>
        public bool IsSealedOrgStudent(string studentid)
        {
            string sql = @"
 SELECT TOP 1 a.* 
 FROM dbo.CoachBootcampStudent  a
 INNER JOIN dbo.CoachOrganization b ON a.SealedOrganizationId=b.Id
 WHERE 
	  StudentId=@StudentId

";
            var cmd = CommandHelper.CreateText<CoachBootcampStudent>(FetchType.Fetch, sql);
            cmd.Params.Add("@StudentId", studentid);
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

    }
}
