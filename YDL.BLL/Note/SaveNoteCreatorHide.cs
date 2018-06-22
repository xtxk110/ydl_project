﻿using System;
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
    /// 隐藏笔记创建人
    /// </summary>
    public class SaveNoteCreatorHide : IServiceBase
    {
     
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<NoteCreatorHide>>(request);
            var obj = req.Entities.FirstOrDefault();

            List<EntityBase> entites = new List<EntityBase>();
            entites.Add(obj);
            if (obj.RowState == RowState.Added)
            {
                obj.SetNewId();
                obj.SetCreateDate();
                obj.WantHideUserId = currentUser.Id;
            }

            return DbContext.GetInstance().Execute(CommandHelper.CreateSave(entites));
        }

    }

}
