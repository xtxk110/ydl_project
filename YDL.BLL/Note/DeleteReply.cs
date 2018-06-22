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
    /// 删除回复
    /// </summary>
    public class DeleteReply : IServiceBase
    {
        /// <summary>
        /// 删除回复
        /// </summary>
        /// <param name="currentUser"></param>
        /// <param name="request">Note</param>
        /// <returns></returns>
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<NoteReply>>(request);
            var reply = req.Entities.FirstOrDefault();

            Command cmd = null;
            
            string sql = @"DELETE FROM NoteReply WHERE Id=@replyId";

            cmd = CommandHelper.CreateText(FetchType.Execute, sql);
            cmd.Params.Add(CommandHelper.CreateParam("@replyId", reply.Id));

            return DbContext.GetInstance().Execute(cmd);

        }

    }

}
