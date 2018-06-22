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
    /// 课程详情-- 确认课程开始
    /// </summary>
    public class SaveCoachCourseStart : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<CoachCourse>>(request);
            var obj = req.FirstEntity();
            if (string.IsNullOrEmpty(obj.CourseContent))
            {
                return ResultHelper.Fail("课程内容不能为空");
            }
            if (string.IsNullOrEmpty(obj.CategoryOfTechnologyId) && obj.Type == CoachDic.PrivateCourse)
            {
                return ResultHelper.Fail("技术类别不能为空");
            }

            Response result = new Response();
            var sql = @" 
 UPDATE dbo.CoachCourse 
 SET CourseContent=@CourseContent , CategoryOfTechnologyId=@CategoryOfTechnologyId ,
        State=@State
 WHERE Id=@Id
";
            var cmd = CommandHelper.CreateText(FetchType.Execute, sql);
            cmd.Params.Add("@Id", obj.Id);
            cmd.Params.Add("@CourseContent", obj.CourseContent);
            cmd.Params.Add("@CategoryOfTechnologyId", obj.CategoryOfTechnologyId);
            cmd.Params.Add("@State", CoachDic.CourseStart);

            result = DbContext.GetInstance().Execute(cmd);
            return result;
        }


    }
}
