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
    /// 保存附件
    /// </summary>
    public class SaveAnnex : IService
    {
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<FileInfo>>(request);
            Response result = AnnexHelper.SaveAnnex(req.Entities);
            result.Entities.AddRange(req.Entities);

            return result;
        }
    }

}
