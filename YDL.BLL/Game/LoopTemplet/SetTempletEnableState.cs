using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Map;
using YDL.Model;
using YDL.Utility;
using Newtonsoft.Json;
using YDL.Core;

namespace YDL.BLL
{
    /// <summary>
    ///启用停用模板
    /// </summary>
    class SetTempletEnableState_198 : IService
    {
        public Response Execute(string request)
        {
            string updateSql = @"UPDATE GameTeamLoopTemplet SET IsEnable=@isEnable WHERE Id=@templetId";
            var req = JsonConvert.DeserializeObject<Request<GameTeamLoopTemplet>>(request);
            var templet = req.Entities[0] as GameTeamLoopTemplet;
            var cmd = CommandHelper.CreateText(FetchType.Execute, updateSql);
            cmd.Params.Add("@templetId", templet.Id);
            cmd.Params.Add("@isEnable", templet.IsEnable);
            var res = DbContext.GetInstance().Execute(cmd);
            if (res.IsSuccess && !templet.IsEnable)
            {
                res.Tag = GameLoopTempletHelper.IsUseTemplet(templet.Id);//停用模板,假如被赛事使用过,则返回true
                ///res.Message = "可删除此模板,需要删除吗?";
            }
            else
                res.Tag = false;
                
            return res;
        }
    }
}
