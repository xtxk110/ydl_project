using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Map;
using YDL.Model;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 检查团体对阵模板名称是否重复,TRUE为重复,且返回队伍1,队伍2编码字符数组(根据上场人数,返回对应规则编码),修改模板时直接返回false
    /// </summary>
    public class GameLoopTempletCheck_198 : IService
    {
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GameTeamLoopTempletFilter>>(request);

            Response res = ResultHelper.Success();
            res.Tag = GameLoopTempletHelper.IsExistTemplet(req.Filter.Name,req.Filter.ModifyFlag);//bool类型 ,TRUE为名称重复
            res.Tag1 = GameLoopTempletHelper.GetRuleCodes(req.Filter.PersonCount,true,true);//队伍1(主队)对阵编码字符数组
            if(req.Filter.IsGuest)
                res.Tag2 = GameLoopTempletHelper.GetRuleCodes(req.Filter.PersonCount,false,true);//队伍2(客队)对阵编码字符数组
            else
                res.Tag2= GameLoopTempletHelper.GetRuleCodes(req.Filter.PersonCount, true, true);//队伍2(客队)对阵编码字符数组
            return res;
        }
        
    }
}
