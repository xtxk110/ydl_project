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
    /// 预约集训的课程
    /// </summary>
    public class SaveBootcampCourseJoin : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<CoachBootcampCourseJoin>>(request);
            var obj = req.FirstEntity();
            Response result;
            //var course = CoachHelper.Instance.GetCoachCourse(obj.CourseId); //课程的 cityId 从场馆取的, 而不是前端传的
            //报名前验证
            if (!HaveBalance(obj))
            {
                return ResultHelper.Fail(ErrorCode.STUDENT_NOTBALANCE, "你的余额次数为0, 不能再预约");
            }

            //先从余额扣除一次
            result = SubOne(obj);
            //扣款成功了再插入报名数据
            if (result.IsSuccess)
            {
                List<EntityBase> entites = new List<EntityBase>();
                entites.Add(obj);

                if (obj.RowState == RowState.Added)
                {
                    
                    obj.TrySetNewEntity();
                }

                result = DbContext.GetInstance().Execute(CommandHelper.CreateSave(entites));
            }

            return result;

        }

        public bool HaveBalance(CoachBootcampCourseJoin obj)
        {
            string sql = "";
            sql = @"
  SELECT 
	SUM(Amount) AS Amount
FROM dbo.CoachStudentMoney 
WHERE StudentUserId=@StudentUserId  
    AND CoachBootcampId=@CoachBootcampId
    
";
            var cmd = CommandHelper.CreateText<CoachStudentMoney>(FetchType.Fetch, sql);
            cmd.Params.Add("@StudentUserId", obj.StudentId);
            cmd.Params.Add("@CoachBootcampId", obj.CoachBootcampId);

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
   
        public Response SubOne(CoachBootcampCourseJoin obj)
        {

            var sql = @" 
 UPDATE  dbo.CoachStudentMoney 
 SET Amount=Amount-1 
 WHERE CoachBootcampId=@CoachBootcampId 
    AND StudentUserId=@StudentId
 ";
            var cmd = CommandHelper.CreateText<ClubUser>(FetchType.Execute, sql);
            cmd.Params.Add("@CoachBootcampId", obj.CoachBootcampId);
            cmd.Params.Add("@StudentId", obj.StudentId);

            var result = DbContext.GetInstance().Execute(cmd);
            return result;
        }



    }
}
