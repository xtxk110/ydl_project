using System;
using System.Linq;

using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;

namespace YDL.BLL
{
    /// <summary>
    /// 保存单个城市信息
    /// </summary>
    public class SaveCity : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<City>>(request);

            return DbContext.GetInstance().Execute(CommandHelper.CreateSave(req.Entities));
        }
    }

}
