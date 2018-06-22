
using Newtonsoft.Json;
using YDL.Map;
using YDL.Utility;
using YDL.Model;

namespace YDL.BLL
{
    /// <summary>
    /// IM搜索用户
    /// </summary>
    public class GetUserListForIM : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetUserListFilter>>(request);
            Response rsp = new Response();
            rsp = GetAllUser(req);
            return rsp;
        }
 
        public Response GetAllUser(Request<GetUserListFilter> req)
        {
            
            var cmd = CommandHelper.CreateProcedure<User>(text: "sp_GetUserListForIM");
            cmd.Params.Add(CommandHelper.CreateParam("@keywords", req.Filter.Keywords.Trim()));
            cmd.CreateParamPager(req.Filter);
            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();

            return result;
        }

    }

}
