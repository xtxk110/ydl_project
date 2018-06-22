using System;
using System.Linq;
using System.Web;

using Newtonsoft.Json;
using YDL.Core;
using YDL.Map;
using YDL.Model;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 删除附件，条件FileInfo对象的MasterId，Id
    /// </summary>
    public class DeleteAnnex : IService
    {
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<FileInfo>>(request);
            return AnnexHelper.DeleteAnnex(req.Filter.Id);
        }
    }

}
