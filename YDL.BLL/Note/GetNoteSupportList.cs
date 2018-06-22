using System.Text;
using System.Collections.Generic;

using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 获取笔记赞列表
    /// </summary>
    public class GetNoteSupportList : IServiceBase
    {
        /// <summary>
        /// 获取笔记赞列表
        /// </summary>
        /// <param name="currentUser"></param>
        /// <param name="request">Note</param>
        /// <returns>NoteSupport</returns>
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<Note>>(request);
            return NoteHelper.GetNoteSupportList(req.Filter.Id);
        }
    }
}
