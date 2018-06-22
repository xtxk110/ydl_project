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
    /// 课程报名
    /// </summary>
    public class SaveCoachCourseJoin : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<CoachCourseJoin>>(request);
            var obj = req.FirstEntity();
            Response result;
            var course = CoachHelper.Instance.GetCoachCourseById(obj.CourseId); //课程的 cityId 从场馆取的, 而不是前端传的
            //报名前验证
            if (!HaveBalance(obj, course.CityId))
            {
                return ResultHelper.Fail(ErrorCode.STUDENT_NOTBALANCE, "你没有可用的余额次数, 请购买");
            }
            if (!IsInJoinState(course.State))
            {
                return ResultHelper.Fail("当前课程已结束或者已开始, 不能报名");
            }

            if (IsJoined(obj))
            {
                return ResultHelper.Fail("此课程您已报名, 不能再报名");
            }

            if (!HaveEmpty(obj.CourseId))//判断有木有空位
            {
                return ResultHelper.Fail("此课程报名已满, 不能再报名");
            }


            //先从余额扣除一次
            result = SubOne(obj, course.CityId);
            //扣款成功了再插入报名数据
            if (result.IsSuccess)
            {
                List<EntityBase> entites = new List<EntityBase>();
                entites.Add(obj);

                if (obj.RowState == RowState.Added)
                {
                    var unitPrice = result.OutParams.Where(e => e.Name == "@ThenCourseUnitPrice").FirstOrDefault();
                    if (unitPrice.value != null)
                    { 
                        //保存当时的课程报名单价(我上这次课花了多少钱,方便后面统计)
                        obj.ThenCourseUnitPrice = (decimal)unitPrice.value;
                    }

                    obj.TrySetNewEntity();
                }

                result = DbContext.GetInstance().Execute(CommandHelper.CreateSave(entites));
            }
            return result;

        }

        public bool HaveBalance(CoachCourseJoin obj, string cityId)
        {
            string sql = "";
            sql = @"
 SELECT 
	SUM(Amount) AS Amount
FROM dbo.CoachStudentMoney 
WHERE StudentUserId=@StudentUserId  
    AND CourseTypeId=@CourseTypeId AND CityId=@CityId
    
";
            var course = CoachHelper.Instance.GetCoacherCourse(obj.CourseId);
            if (course.Type == "027001") //大课有 有效期限制 , 私教没有
            {
                sql += " AND Deadline>GETDATE() ";
            }

            if (course.Type == "027003")  //私教才去匹配教练字段, 大课不用
            {
                sql += " AND CoachId = @CoachId ";
            }
            var cmd = CommandHelper.CreateText<CoachStudentMoney>(FetchType.Fetch, sql);
            cmd.Params.Add("@StudentUserId", obj.StudentId);
            cmd.Params.Add("@CoachId", obj.CoachId);
            cmd.Params.Add("@CourseTypeId", course.Type);
            cmd.Params.Add("@CityId", cityId);


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
        public bool HaveEmpty(string courseId)
        {
            //获取课程已报名人数
            var sql = @"
 SELECT 
     COUNT(Id)
 FROM dbo.CoachCourseJoin
 WHERE CourseId = @CourseId
                ";
            var cmdVal = CommandHelper.CreateText<ClubUser>(FetchType.Scalar, sql);
            cmdVal.Params.Add("@CourseId", courseId);
            var result = DbContext.GetInstance().Execute(cmdVal);
            int fillCount = 0;
            if (result.Tag != null)
            {
                fillCount = (int)result.Tag;
            }

            //获取课程类型
            var courseType = CoachHelper.Instance.GetCoacherCourse(courseId).Type;

            //计算剩余空位数
            var emptyPosition = CoachHelper.CountEmptyPosition(fillCount, courseType);

            if (emptyPosition > 0)
            {
                return true;
            }
            else
            {
                return false;
            }

        }
        public bool IsJoined(CoachCourseJoin obj)
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

            if (result.Entities.Count > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        public bool IsInJoinState(string courseState)
        {
            if (courseState == CoachDic.CourseJoin)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public Response SubOne(CoachCourseJoin obj, string cityId)
        {
            var cmd = CommandHelper.CreateProcedure<CoacherApply>(text: "sp_ReserveCourseSubOne");
            cmd.Params.Add(CommandHelper.CreateParam("@StudentUserId", obj.StudentId));
            cmd.Params.Add(CommandHelper.CreateParam("@CoacherUserId", obj.CoachId));
            cmd.Params.Add(CommandHelper.CreateParam("@CourseId", obj.CourseId));
            cmd.Params.Add(CommandHelper.CreateParam("@CityId", cityId));
            cmd.Params.Add(CommandHelper.CreateParam("@ThenCourseUnitPrice", 0, DataType.Decimal, ParamDirection.Output));
            cmd.Params.Add(CommandHelper.CreateParam("@Type", "Join"));//报名
            cmd.CreateParamMsg();

            var result = DbContext.GetInstance().Execute(cmd);

            return result;
        }



    }
}
