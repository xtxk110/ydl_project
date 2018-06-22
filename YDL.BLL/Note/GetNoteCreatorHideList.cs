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
    /// 获取隐藏的笔记创建人列表
    /// </summary>
    public class GetNoteCreatorHideList : IServiceBase
    {

        public Response Execute(User currentUser, string request)
        {
            var sql = @"
 SELECT
	b.*
 FROM dbo.NoteCreatorHide a
 INNER JOIN dbo.UserAccount b ON a.HideCreatorId=b.Id
 WHERE a.WantHideUserId=@userId

";
            var cmd = CommandHelper.CreateText<User>(FetchType.Fetch, sql);
            cmd.Params.Add("@userId", currentUser.Id);
            var result = DbContext.GetInstance().Execute(cmd);
            return result;
        }

    }

}
