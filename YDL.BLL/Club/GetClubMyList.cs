
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;

namespace YDL.BLL
{
    /// <summary>
    /// 获取与我有关的俱乐部（我创建的，加入的）
    /// </summary>
    public class GetClubMyList : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var cmd = CommandHelper.CreateProcedure<Club>(text: "sp_GetClubMyList");
            cmd.Params.Add(CommandHelper.CreateParam("@userId", currentUser.Id));

            return DbContext.GetInstance().Execute(cmd);
        }
    }

}
