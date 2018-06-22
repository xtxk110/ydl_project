using System.Text;
using System.Collections.Generic;

using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 获取用户权限申请列表，单个需传递UserId，可传递处理状态 (done)
    /// </summary>
    public class GetUserLimitRequestList : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetUserLimitListFilter>>(request);

            var cmd = CommandHelper.CreateProcedure<UserLimitRequest>(text: "sp_GetUserLimitRequestList");
            cmd.CreateParamUser(currentUser.Id);
            cmd.CreateParamPager(req.Filter);
            cmd.Params.Add("@isProcessed", req.Filter.IsProcessed);

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();

            return result;
        }
    }
}
