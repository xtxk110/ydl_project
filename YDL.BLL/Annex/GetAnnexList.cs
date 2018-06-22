
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;

namespace YDL.BLL
{
    /// <summary>
    /// 获取附件列表
    /// </summary>
    public class GetAnnexList : IService
    {
        /// <summary>
        /// 获取附件列表
        /// </summary>
        /// <param name="request">包含AnnexInfo对象，设置属性值MasterId</param>
        /// <returns></returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<FileInfo>>(request);
            return AnnexHelper.GetAnnexList(req.Filter.MasterId);
        }
    }

}
