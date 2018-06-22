using System;
using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Core;
using YDL.Utility;
using System.Collections.Generic;

namespace YDL.BLL
{
    /// <summary>
    /// 教练提升等级
    /// </summary>
    public class UpdateCoachGrade : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<Coach>>(request);
            var obj = req.FirstEntity();
            Response result = new Response();
            var sql = @"UPDATE dbo.Coach SET Grade=@Grade WHERE Id=@Id";
            var cmd = CommandHelper.CreateText(FetchType.Execute, sql);
            cmd.Params.Add("@Id", obj.Id);
            cmd.Params.Add("@Grade", obj.Grade);
            result = DbContext.GetInstance().Execute(cmd);
            return result;

        }

    }
}
