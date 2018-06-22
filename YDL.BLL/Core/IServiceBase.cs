using YDL.Map;
using YDL.Model;

namespace YDL.BLL
{
    /// <summary>
    /// 服务接口,需要验证用户
    /// </summary>
    public interface IServiceBase
    {
        Response Execute(User currentUser, string request);
    }
}
