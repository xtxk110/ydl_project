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
    /// 判断当前登陆者是不是教练
    /// </summary>
    public class IsCoacher : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            Response rsp = CoachHelper.Instance.GetIsCoacher(currentUser.Id);
            var user = rsp.FirstEntity<User>();
            if (user != null)
            {
                user.IsSealedCoach =CoachHelper.Instance.IsSealedCoach(currentUser.Id);
            }
            return rsp;
        }


    }
}
