using System.Linq;
using System.Configuration;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using RestSharp;
using System;
using YDL.Utility;
using cn.jpush.api.push.mode;
using System.Collections.Generic;

namespace YDL.BLL
{
    /// <summary>
    /// 单发单聊消息
    /// </summary>
    public class SendSingleMsg : IServiceBase
    {
        /// <summary>
        /// 单发单聊消息
        /// </summary>
        /// <param name="currentUser"></param>
        /// <param name="request"></param>
        /// <returns></returns>
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<User>>(request);

            //CustomInfo customInfo = new CustomInfo();
            //customInfo.Id = Ext.NewId();
            //customInfo.Type = "ReservedCourseDetail";
            //customInfo.TypeName = "课程消息";
            //customInfo.BusinessId = "76b4ae1e80d0488eb919a823009e5cc5";
            //customInfo.Message = "xx学员对你约课成功, 请查看";
            //customInfo.CreateDate = DateTime.Now;

            Dictionary<string, object> extras = new Dictionary<string, object>();
            extras.Add("Type", SystemMessageType.CoachReservedCourseDetail);
            extras.Add("BusinessId", "76b4ae1e80d0488eb919a823009e5cc5");
            extras.Add("Message", "xx学员对你约课成功, 请查看");

            JPushHelper.SendCourseSystemMessage(extras, req.Filter.Id);
            Response rsp = new Response();
            rsp.IsSuccess = true;
            return rsp;
        }


    }
}
