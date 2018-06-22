using System.Text;
using System.Collections.Generic;

using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 获取用户权限列表，单个需传递UserId (done)
    /// </summary>
    public class GetUserLimitList : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetUserLimitListFilter>>(request);

            var cmd = CommandHelper.CreateProcedure<UserLimit>(text: "sp_GetUserLimitList");
            cmd.CreateParamUser(req.Filter.UserId);
            cmd.CreateParamPager(req.Filter);

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();

            return result;
        }
    }
}
