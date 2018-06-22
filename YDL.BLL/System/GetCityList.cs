using System.Text;
using System.Collections.Generic;

using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 获取城市列表(done)
    /// </summary>
    public class GetCityList : IService
    {
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetCityListFilter>>(request);

            var cmd = CommandHelper.CreateProcedure<City>(text: "sp_GetCityList");
            cmd.Params.Add(CommandHelper.CreateParam("@Name", req.Filter.Name));
            cmd.CreateParamPager(req.Filter);

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();

            return result;
        }
    }

}
