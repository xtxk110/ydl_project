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
    /// 保存比赛裁判
    /// </summary>
    public class SaveGameJudge : IService
    {
        /// <summary>
        /// 保存比赛裁判
        /// </summary>
        /// <param name="currentUser">忽略</param>
        /// <param name="request">Request.GameJudge</param>
        /// <returns>Response.EmptyEntity</returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GameJudge>>(request);
            foreach (var obj in req.Entities)
            {
                if (obj.RowState == RowState.Added)
                {
                    obj.SetNewId();
                    obj.SetCreateDate();
                }
            }

            return DbContext.GetInstance().Execute(CommandHelper.CreateSave(req.Entities));
        }
    }
}
