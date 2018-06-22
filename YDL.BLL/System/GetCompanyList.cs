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
    /// 获取单位列表
    /// </summary>
    public class GetCompanyList : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetCompanyListFilter>>(request);

            var cmd = CommandHelper.CreateProcedure<Company>(text: "sp_GetCompanyList");
            cmd.Params.Add(CommandHelper.CreateParam("@Name", req.Filter.Name));
            cmd.Params.Add(CommandHelper.CreateParam("@IsManage", req.Filter.IsManage));
            cmd.Params.Add(CommandHelper.CreateParam("@showAll", req.Filter.ShowAll, DataType.Boolean));
            cmd.CreateParamPager(req.Filter);

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();

            return result;
        }
    }



}
