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
    /// 保存客户端RegId
    /// </summary>
    public class SaveMsgReg : IServiceBase
    {
        /// <summary>
        /// 保存客户端RegId
        /// </summary>
        /// <param name="currentUser">忽略</param>
        /// <param name="request">Request.MsgReg</param>
        /// <returns>Response.EmptyEntity</returns>
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<MsgReg>>(request);
            var obj = req.Entities.FirstOrDefault();
            var cmd = CommandHelper.CreateProcedure(FetchType.Execute, "sp_SaveMsgReg");
            cmd.CreateParamUser(currentUser.Id);
            cmd.Params.Add(CommandHelper.CreateParam("@regId", obj.RegId));
            var result = DbContext.GetInstance().Execute(cmd);
            //测试代码
            //JPushTest.SendAMsg(currentUser);
            return result;
        }
    }
}
