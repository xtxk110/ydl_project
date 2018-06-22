
using System.Collections.Generic;
using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Utility;
using YDL.Core;
using System;

namespace YDL.BLL
{
    /// <summary>
    /// 获取竞猜列表
    /// </summary>
    public class GetGuessList_188 : IService
    {

        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetGuessRelatedFilter>>(request);
            var cmd = CommandHelper.CreateProcedure<Guess>(text: "GetGuessList");
            cmd.Params.Add(CommandHelper.CreateParam("@GuessName", req.Filter.GuessName));
            cmd.Params.Add(CommandHelper.CreateParam("@CreatorId", req.Filter.CreatorId));
            cmd.Params.Add(CommandHelper.CreateParam("@State", req.Filter.State));
            cmd.Params.Add(CommandHelper.CreateParam("@CurrentTime", DateTime.Now));
            cmd.Params.Add(CommandHelper.CreateParam("@GameId", req.Filter.GameId));

            cmd.CreateParamPager(req.Filter);

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();
            foreach (var item in result.Entities)
            {
                var obj = item as Guess;
                //处理竞猜状态
                GuessHelper.Instance.DealState(obj);
                //获取对阵详情
                obj.GuessVSDetail = GuessHelper.Instance.GetVSDetail(obj);
                obj.PersonTotal = GuessHelper.Instance.GetGuessTotalPerson(obj.Id);
                obj.YueDouTotal = GuessHelper.Instance.GetGuessTotalYueDou(obj.Id);

            }
            return result;
        }



    }

}
