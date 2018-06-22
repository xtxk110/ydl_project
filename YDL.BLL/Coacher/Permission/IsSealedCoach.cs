using System;
using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Core;
using YDL.Utility;
using System.Dynamic;

namespace YDL.BLL
{
    /// <summary>
    /// 判断当前登陆者是不是封闭机构教练
    /// </summary>
    public class IsSealedCoach : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            Response rsp = ResultHelper.CreateResponse();
            rsp.Tag = CoachHelper.Instance.IsSealedCoach(currentUser.Id);
            return rsp;
        }


    }
}
