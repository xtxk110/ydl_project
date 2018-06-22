using System;
using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Core;
using YDL.Utility;
using System.Collections.Generic;

namespace YDL.BLL
{
    public class GetNationalFlagList : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetTVRelatedFilter>>(request);
            var cmd = CommandHelper.CreateProcedure<NationalFlag>(text: "GetNationalFlagList");
            cmd.Params.Add(CommandHelper.CreateParam("@NationalName", req.Filter.NationalName));
            cmd.CreateParamPager(req.Filter);

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();

            return result;
        }


    }
}
