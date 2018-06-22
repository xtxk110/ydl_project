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
    /// 保存笔记回复
    /// </summary>
    public class SaveNoteReply : IServiceBase
    {
        /// <summary>
        /// 保存笔记回复
        /// </summary>
        /// <param name="currentUser"></param>
        /// <param name="request">NoteReply</param>
        /// <returns></returns>
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<NoteReply>>(request);
            var note = req.Entities.FirstOrDefault();
            if (note.RowState != RowState.Deleted && note.MasterType.IsNullOrEmpty())
            {
                return ResultHelper.Fail("关联类型字段 MasterType 的值为空, 请传该字段值");
            }
            note.UserId = note.UserId.GetId();
            note.NoteId = note.NoteId.GetId();
            List<EntityBase> entites = new List<EntityBase>();
            entites.Add(note);
            if (note.RowState == RowState.Added)
            {
                note.TrySetNewEntity();
            }

            return DbContext.GetInstance().Execute(CommandHelper.CreateSave(entites));
        }

    }

}
