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
    /// 移除隐藏的笔记创建人
    /// </summary>
    public class DeleteNoteCreatorHide : IServiceBase
    {

        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<User>>(request);
            var obj = req.Entities.FirstOrDefault();

            Command cmd = null;
            string sql = @"
DELETE FROM dbo.NoteCreatorHide 
WHERE WantHideUserId=@WantHideUserId AND HideCreatorId=@HideCreatorId
             ";
            cmd = CommandHelper.CreateText(FetchType.Execute, sql);
            cmd.Params.Add(CommandHelper.CreateParam("@WantHideUserId", currentUser.Id));
            cmd.Params.Add(CommandHelper.CreateParam("@HideCreatorId", obj.Id));

            return DbContext.GetInstance().Execute(cmd);


        }

    }

}
