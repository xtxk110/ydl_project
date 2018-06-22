using System.Text;
using System.Collections.Generic;

using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Utility;
using YDL.Core;

namespace YDL.BLL
{
    /// <summary>
    /// 获取单位公司信息
    /// </summary>
    public class GetCompany : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<Company>>(request);

            var cmd = CommandHelper.CreateProcedure<Company>(text: "sp_GetCompany");
            cmd.CreateParamId(req.Filter.Id);
            var result = DbContext.GetInstance().Execute(cmd);

            return result;
        }
    }

}
