using System;
using System.Linq;
using System.Collections.Generic;

using Newtonsoft.Json;
using YDL.Core;
using YDL.Map;
using YDL.Model;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 保存笔记赞
    /// </summary>
    public class SaveNoteSupport : IServiceBase
    {
        /// <summary>
        /// 保存笔记赞
        /// </summary>
        /// <param name="currentUser"></param>
        /// <param name="request">NoteSupport</param>
        /// <returns></returns>
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<NoteSupport>>(request);
            var note = req.Entities.FirstOrDefault();

            var cmd = CommandHelper.CreateProcedure(FetchType.Execute, "sp_SaveNoteSupport");
            cmd.Params.Add("@noteId", note.NoteId);
            cmd.CreateParamUser(note.UserId.GetId());

            return DbContext.GetInstance().Execute(cmd);
        }

    }

}
