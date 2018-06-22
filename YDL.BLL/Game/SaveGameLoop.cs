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
    /// 保存场次循环
    /// </summary>
    public class SaveGameLoop : IService
    {
        /// <summary>
        /// 保存场次循环
        /// </summary>
        /// <param name="currentUser">忽略</param>
        /// <param name="request">Request.GameLoop</param>
        /// <returns>Response.EmptyEntity</returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GameLoop>>(request);
            var game = req.Entities.FirstOrDefault();

            return DbContext.GetInstance().Execute(CommandHelper.CreateSave(req.Entities));
        }
    }
}
