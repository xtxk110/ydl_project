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
    /// 保存教练课程分享
    /// </summary>
    public class SaveCoachCourseShare : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<Note>>(request);
            var obj = req.FirstEntity();
            if (string.IsNullOrEmpty(obj.Content))
            {
                return ResultHelper.Fail("请为你分享的内容加一段话");
            }
            return CoachHelper.Instance.CoacherCourseShare(obj, currentUser.Id);
        }


    }
}
