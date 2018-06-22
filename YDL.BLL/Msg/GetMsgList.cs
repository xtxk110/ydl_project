using System.Text;
using System.Collections.Generic;

using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 获取消息列表
    /// </summary>
    public class GetMsgList : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetMsgListFilter>>(request);

            var cmd = CommandHelper.CreateProcedure<Msg>(text: "sp_GetMsgList");
            cmd.CreateParamUser(currentUser.Id);
            cmd.CreateParamPager(req.Filter);

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();

            return result;
        }
    }
}
