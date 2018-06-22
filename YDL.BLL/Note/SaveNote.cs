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
    /// 保存笔记
    /// </summary>
    public class SaveNote : IServiceBase
    {
        /// <summary>
        /// 保存笔记
        /// </summary>
        /// <param name="currentUser"></param>
        /// <param name="request">Note</param>
        /// <returns></returns>
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<Note>>(request);
            var note = req.Entities.FirstOrDefault();

            List<EntityBase> entites = new List<EntityBase>();
            entites.Add(note);
            if (note.RowState == RowState.Added)
            {
                note.SetNewId();
                note.SetCreateDate();
                note.CreatorId = currentUser.Id;
 
            }

            //获取将要保存的图片列表
            note.GetWillSaveFileList(entites);


            return DbContext.GetInstance().Execute(CommandHelper.CreateSave(entites));
        }

    }

}
