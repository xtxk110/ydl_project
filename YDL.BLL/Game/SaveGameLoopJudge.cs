using System;
using System.Text;
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
    /// 设置比赛裁判，开始时间
    /// </summary>
    public class SaveGameLoopJudge : IService
    {
        /// <summary>
        /// 设置比赛裁判，开始时间
        /// </summary>
        /// <param name="currentUser">忽略</param>
        /// <param name="request">Request.GameLoop</param>
        /// <returns>Response.EmptyEntity</returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GameLoop>>(request);
            var cmd = CommandHelper.CreateSave(req.Entities);
            foreach (var loop in req.Entities)
            {
                loop.JudgeId = loop.JudgeId.GetId();
                loop.MasterJudgeId = loop.MasterJudgeId.GetId();
            }
            cmd.OnlyFields = new List<TableFieldPair> { new TableFieldPair { Table = "GameLoop", Fields = "BeginTime,JudgeId,MasterJudgeId,TableNo" } };

            return DbContext.GetInstance().Execute(cmd);
        }
    }
}
