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
    /// 删除笔记
    /// </summary>
    public class DeleteNote : IServiceBase
    {
        /// <summary>
        /// 删除笔记
        /// </summary>
        /// <param name="currentUser"></param>
        /// <param name="request">Note</param>
        /// <returns></returns>
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<Note>>(request);
            var note = req.Entities.FirstOrDefault();

            Command cmd = null;
            //删除笔记+笔记点赞+笔记回复+被隐藏的笔记
            string sql = @"
            DELETE FROM NoteSupport WHERE  NoteId=@noteId 
            DELETE FROM NoteReply WHERE  NoteId = @noteId
            DELETE FROM NoteHide WHERE  HideNoteId = @noteId
            DELETE FROM Note WHERE  Id = @noteId
            ";
            cmd = CommandHelper.CreateText(FetchType.Execute, sql);
            cmd.Params.Add(CommandHelper.CreateParam("@noteId", note.Id));
            cmd.Params.Add(CommandHelper.CreateParam("@userId", currentUser.Id));

            return DbContext.GetInstance().Execute(cmd);


        }

    }

}
