using System;
using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Core;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 获取教练课程详细信息
    /// </summary>
    public class GetCoachCourse : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetCoachRelatedFilter>>(request);

            var sql = @"
SELECT 
	a.*,
	d.Id AS CoacherUserId,
    d.Sex,
	d.CardName AS CoachName,
    d.HeadUrl AS CoacherHeadUrl,
	b.Name AS TypeName,
	c.Address AS VenueAddress,
    c.Name AS VenueName,
	FillPosition=(SELECT COUNT(*) FROM dbo.CoachCourseJoin WHERE CourseId=@CourseId),
	IsJoined=(SELECT COUNT(*) FROM dbo.CoachCourseJoin WHERE CourseId=@CourseId AND StudentId=@StudentUserId),
	IsComment=(SELECT  COUNT(*)  FROM dbo.CoachComment WHERE CourseId=@CourseId AND CommentatorId=@StudentUserId),
    e.Name AS CategoryOfTechnologyName,
	f.Name AS CityName,
	CoachBootcampId=(SELECT CoachBootcampId FROM dbo.CoachBootcampCourse WHERE a.CoachBootcampCourseId=Id)
FROM dbo.CoachCourse a
LEFT JOIN dbo.UserAccount d ON a.CoachId=d.Id
LEFT JOIN dbo.BaseData b ON a.Type=b.Id
LEFT JOIN dbo.Venue c ON a.VenueId=c.Id
LEFT JOIN dbo.SysDic e ON a.CategoryOfTechnologyId=e.Id
LEFT JOIN dbo.City f ON a.CityId=f.Id
WHERE a.Id=@CourseId    

";
            var cmd = CommandHelper.CreateText<CoachCourse>(FetchType.Fetch, sql);
            cmd.Params.Add("@CourseId ", req.Filter.CourseId);
            cmd.Params.Add("@StudentUserId ", req.Filter.CurrentUserId);//@StudentUserId 变量仅用于学员 IsJoined ,IsComment 字段的计算 

            var result = DbContext.GetInstance().Execute(cmd);
            var obj = result.FirstEntity<CoachCourse>();
            if (obj == null)
            {
                return ResultHelper.Fail(ErrorCode.DATA_NOTEXIST, "未找到此课程信息");
            }

            obj.TryGetFiles();
            //获取课程学员
            var studentList = CoachHelper.GetStudentList(req.Filter.CourseId);
            if (studentList.Count > 0)
            {
                obj.StudentList.AddRange(studentList);
            }

            //计算空位
            obj.EmptyPosition = CoachHelper.CountEmptyPosition(obj.FillPosition, obj.Type);

            #region 计算课程状态-- 下面的状态界面用
            var isCoach = CoachHelper.Instance.IsCoach(req.Filter.CurrentUserId);
            if (isCoach == true) //教练 课程状态计算
            {
                if (obj.CoachId == req.Filter.CurrentUserId) //当前登陆者是此节课的教练,才能进行下面的操作
                {
                    if (obj.State == CoachDic.CourseJoin && obj.FillPosition != 0/*有学员报名*/
                        && obj.EndTime > DateTime.Now/*课程结束时间大于当前时间*/)
                    {
                        obj.CourseState = "ConfirmStart";
                    }
                    else if (obj.State == CoachDic.CourseStart)
                    {
                        obj.CourseState = "ConfirmFinished";
                    }
                    else if (obj.State == CoachDic.CourseFinished)
                    {
                        obj.CourseState = "CourseFinished";
                    }
                    else
                    {
                        obj.CourseState = "NotOperate";
                    }
                }
                else
                {
                    obj.CourseState = "NotPermission";
                }


            }
            else //学员  课程状态计算
            {
                if (obj.IsJoined == 0 && obj.State != CoachDic.CourseFinished/*课程未结束*/
                    && obj.EndTime > DateTime.Now /*课程结束时间大于当前时间*/)
                {
                    obj.CourseState = "Join"; //课程可以报名
                }
                if (obj.IsJoined == 0 && obj.State != CoachDic.CourseFinished/*课程未结束*/
                   && obj.EndTime <= DateTime.Now /*课程结束时间大于当前时间*/)
                {
                    obj.CourseState = "NotJoin"; //课程不可以报名
                }
                else if (obj.IsJoined == 1 && obj.State != CoachDic.CourseFinished/*课程未结束*/
                    && obj.IsComment == 0/*没有评论*/ )
                {
                    obj.CourseState = "CanNotComment"; //课程还没结束, 不能评价,不显示评价按钮
                }
                else if (obj.IsJoined == 1/*已报名*/ && obj.State == CoachDic.CourseFinished/*课程已结束*/
                    && obj.IsComment == 0/*没有评论*/ )
                {
                    obj.CourseState = "Comment"; //课程已结束,能评价 
                }
                else if (obj.IsJoined == 1/*已报名*/ && obj.State == CoachDic.CourseFinished/*课程已结束*/
                    && obj.IsComment == 1/*已评论*/ )
                {
                    obj.CourseState = "Commented"; //已评价 
                }

            }


            #endregion 计算课程状态-- 下面的状态界面用

            //当前登录者是否为场馆的课程管理员
            obj.IsCurrentCourseManager = CoachHelper.Instance.IsCurrentVenueCourseManager(req.Filter.CurrentUserId, obj.VenueId);
            if (obj.Type == CoachDic.BootcampCourse)
            {
                if (obj.CreatorId == currentUser.Id)
                {
                    obj.CoachBootcampCourseDetailCanEdit = true; //如果这个课程是当前登陆者创建的, 那么这个用户可以编辑
                }
                else
                {
                    obj.CoachBootcampCourseDetailCanEdit = false;
                }
            }

            return result;


        }


    }
}
