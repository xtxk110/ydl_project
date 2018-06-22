using System;
using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Core;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    ///通过code获取用户Id 
    /// </summary>
    public class GetUserIdByCode : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetIMRelatedFilter>>(request);
            var sql = @"
SELECT Id FROM dbo.UserAccount WHERE Code=@Code
";
            var cmd = CommandHelper.CreateText<User>(FetchType.Fetch, sql);
            cmd.Params.Add("@Code", req.Filter.UserCode);
            var result = DbContext.GetInstance().Execute(cmd);
            return result;
        }

    }
}
