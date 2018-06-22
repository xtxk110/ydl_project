
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;

namespace YDL.BLL
{
    /// <summary>
    /// 获取运动类别列表(done)
    /// </summary>
    public class GetSportTypeList : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request>(request);
            var cmd = CommandHelper.CreateText<SportType>(text: "SELECT * FROM SportType");

            return DbContext.GetInstance().Execute(cmd);
        }
    }

}
