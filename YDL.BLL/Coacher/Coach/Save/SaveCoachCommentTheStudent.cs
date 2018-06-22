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
    /// 保存教练对学员的评价
    /// </summary>
    public class SaveCoachCommentTheStudent_186 : IServiceBase
    {

        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<CoachCommentStudent>>(request);
            var obj = req.FirstEntity();
            var coachCourse = CoachHelper.Instance.GetCoachCourseById(obj.CourseId);
            List<EntityBase> entites = new List<EntityBase>();
            entites.Add(obj);
            if (obj.RowState == RowState.Added)
            {

                obj.CommentatorId = currentUser.Id;
                obj.TrySetNewEntity();
            }

            //处理头像
            obj.ModifyHeadIcon();
            //获取将要保存的图片列表
            obj.GetWillSaveFileList(entites);

            var result = DbContext.GetInstance().Execute(CommandHelper.CreateSave(entites));

            if (result.IsSuccess && !string.IsNullOrEmpty(obj.CourseSummary))
            {
                SendJG(coachCourse.ReservedPersonId, coachCourse.Id);
            }
            return result;

        }

        public void SendJG(string reserveId, string courseId)
        {
            try
            {
                Dictionary<string, object> extrasToStudent = new Dictionary<string, object>();
                extrasToStudent.Add("Type", SystemMessageType.StudentReservedCourseDetail);
                extrasToStudent.Add("BusinessId", courseId);
                extrasToStudent.Add("Message", "教练对你进行了课程总结, 请查看");
                JPushHelper.SendCourseSystemMessage(extrasToStudent, reserveId);
            }
            catch (Exception)
            {

            }

       
        }


    }
}
