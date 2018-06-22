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
    /// 测试JPush
    /// </summary>
    public class JPushTest : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            return SendAMsg(currentUser);
        }

        public static Response SendAMsg(User currentUser)
        {
            Response result = new Response();
            result.IsSuccess = true;
            JPushHelper.SendNotify(MasterType.USER.Id, currentUser.Id, "你登录成功了", new List<string> { currentUser.Id });

            return result;
        }



    }
}
