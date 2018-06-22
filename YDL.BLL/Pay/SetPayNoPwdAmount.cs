using System;
using System.Collections.Generic;
using System.Linq;

using Newtonsoft.Json;
using YDL.Core;
using YDL.Map;
using YDL.Model;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 设置免密额度
    /// </summary>
    public class SetPayNoPwdAmount : IService
    {

        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<User>>(request);
            var user = req.Entities.FirstOrDefault();

            if (user.PayNoPwdAmount < 0)
            {
                return ResultHelper.Fail("免密额度不能为负数。");
            }

            var sql = @"UPDATE dbo.UserAccount SET PayNoPwdAmount=@PayNoPwdAmount WHERE Id=@Id ";
            var cmd = CommandHelper.CreateText<User>(FetchType.Execute, sql);
            cmd.Params.Add("@PayNoPwdAmount", user.PayNoPwdAmount);
            cmd.Params.Add("@Id", user.Id);

            var result = DbContext.GetInstance().Execute(cmd);
            return result;
        }
    }

}
