using System.Text;
using System.Collections.Generic;

using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 获取笔记回复列表
    /// </summary>
    public class GetNoteReplyList : IService
    {
        /// <summary>
        /// 获取笔记回复列表
        /// </summary>
        /// <param name="currentUser"></param>
        /// <param name="request">GetNoteReplyListFilter</param>
        /// <returns>NoteReply</returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetNoteReplyListFilter>>(request);

            var cmd = CommandHelper.CreateProcedure<NoteReply>(text: "sp_GetNoteReplyList");
            cmd.Params.Add("@noteId", req.Filter.NoteId);
            cmd.CreateParamPager(req.Filter);

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();

            return result;
        }
    }
}
