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
    /// 检查比赛密码签名
    /// </summary>
    public class CheckGameSign : IService
    {
        /// <summary>
        /// 检查比赛密码签名
        /// </summary>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GameSign>>(request);
            var sign = req.FirstEntity();
            if (sign == null)
            {
                return ResultHelper.Fail("Filter没有赋值。");
            }

            if ((sign.TeamId.IsNullOrEmpty() && sign.UserId.IsNullOrEmpty()) || sign.Password.IsNullOrEmpty())
            {
                return ResultHelper.Fail("请输入帐号和密码。");
            }

            var cmd = CommandHelper.CreateProcedure(FetchType.Scalar, "sp_CheckGameSign");
            cmd.Params.Add("@userId", sign.UserId);
            cmd.Params.Add("@teamId", sign.TeamId);
            cmd.Params.Add("@password", sign.Password);

            var result = DbContext.GetInstance().Execute(cmd);
            if ((int)result.Tag > 0)
            {
                return ResultHelper.Success("签字成功。");
            }
            else
            {
                return ResultHelper.Fail("密码错误，签字失败。");
            }

        }
    }

}
