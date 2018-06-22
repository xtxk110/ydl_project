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
    /// 取消预约的集训课程
    /// </summary>
    public class SaveBootcampCourseNotJoin : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<CoachBootcampCourseJoin>>(request);
            var obj = req.FirstEntity();
            Response result;
            //取消前判断此学员是不是已经被安排课了, 安排了就不能取消预约
            if (CoachHelper.Instance.IsHaveCourse(obj.StudentId, obj.BootcampCourseId))
            {
                return ResultHelper.Fail("你已被安排课程, 不能取消预约");
            }

            //删除报名记录
            var sql = @"
DELETE FROM CoachBootcampCourseJoin 
WHERE StudentId=@StudentId 
    AND BootcampCourseId=@BootcampCourseId";
            var cmd = CommandHelper.CreateText<CoachBootcampCourseJoin>(FetchType.Execute, sql);
            cmd.Params.Add("@StudentId", obj.StudentId);
            cmd.Params.Add("@BootcampCourseId", obj.BootcampCourseId);
            result = DbContext.GetInstance().Execute(cmd);
            if (result.IsSuccess)
            {
                //余额增加一次
                result = AddOne(obj);
            }

            return result;

        }


        public Response AddOne(CoachBootcampCourseJoin obj)
        {

            var sql = @" 
 UPDATE  dbo.CoachStudentMoney 
 SET Amount=Amount+1 
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
