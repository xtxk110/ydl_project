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
    /// 保存举报内容
    /// </summary>
    public class SaveNoteWhistleBlowing : IServiceBase
    {

        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<WhistleBlowing>>(request);
            var obj = req.Entities.FirstOrDefault();

            List<EntityBase> entites = new List<EntityBase>();
            entites.Add(obj);
            if (obj.RowState == RowState.Added)
            {
                obj.SetNewId();
                obj.SetCreateDate();
                obj.WhistleBlowingUserId = currentUser.Id;
            }

            return DbContext.GetInstance().Execute(CommandHelper.CreateSave(entites));
        }

    }

}
