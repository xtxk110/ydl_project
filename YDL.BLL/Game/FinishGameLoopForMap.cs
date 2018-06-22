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
    /// 团体比赛设置一次对阵比赛结果
    /// </summary>
    public class FinishGameLoopForMap : IService
    {
        /// <summary>
        /// 团体比赛设置一次对阵比赛结果
        /// </summary>
        /// <param name="request">Request.GameLoopMap.Entities</param>
        /// <returns>Response.EmptyEntity</returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GameLoopMap>>(request);
            var map = req.FirstEntity();
            if (map == null)
            {
                return ResultHelper.Fail("没有传递数据对象。");
            }

            map.Team1Id = map.Team1Id.GetId();
            map.Team2Id = map.Team2Id.GetId();
            map.WinSign = map.WinSign;
            map.JudgeSign = map.JudgeSign;

            map.SetRowModified();
            var entities = new List<EntityBase> { map };

            IWaiver waiver = new MapWaiver();
            if (map.WaiverOption.IsNotNullOrEmpty())
            {
                waiver.SetWaiver(map);
            }
            else
            {
                waiver.SetScore(map);
                var order = GameHelper.GetGameOrderByLoop(map.LoopId.GetId());

                int max = map.Game1 > map.Game2 ? map.Game1 : map.Game2;

                //取胜局（乒超团队模式每场胜局不一样）
                var winGame = map.WinGame > 0 ? map.WinGame : order.WinGame;
                //南充比赛临时要求更改
                //if (!map.User1Id.Contains(",") && !map.User2Id.Contains(",")) //南充比赛临时要求更改,双打不检查胜局
                //{
                    if (max != winGame)
                    {
                        //个人比赛胜局检查
                        return ResultHelper.Fail(string.Format("胜方需要赢{0}局。", winGame));
                    }
                //}
                

                foreach (var item in map.DetailList)
                {

                    //item.SetNewEntity();
                    item.LoopId = map.LoopId.GetId();
                    item.MapId = map.Id.GetId();

                    int maxFen = item.Fen1 > item.Fen2 ? item.Fen1 : item.Fen2;
                    if (maxFen >= 11)//大致判小局分数是否有效
                    {
                        item.RowState = RowState.Modified;//获取小局对阵列表时,已经生成空对阵,故此处只需要保存相应小局的得分,状态更改为修改状态
                        entities.Add(item);
                    }

                }
            }

            var cmdSave = CommandHelper.CreateSave(entities);
            //cmdSave.PreCommands = new List<Command> { GameHelper.GetDeleteLoopDetailCmd(map.LoopId, map.Id) };//此处不需要再删除原有的对阵

            return DbContext.GetInstance().Execute(cmdSave);
        }

    }
}
