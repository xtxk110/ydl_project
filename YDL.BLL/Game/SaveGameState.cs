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
    /// 更新比赛状态
    /// </summary>
    public class SaveGameState : IService
    {
        /// <summary>
        /// 更新比赛状态
        /// </summary>
        /// <param name="currentUser">忽略</param>
        /// <param name="request">Request.Game</param>
        /// <returns>Response.EmptyEntity</returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<Game>>(request);
            var game = req.Entities.FirstOrDefault();
            //进行中的比赛不能取消
            var dbGame = GameHelper.GetGame(game.Id);
            if (game.State.GetId() == GameState.CANCEL.Id && dbGame.State.GetId() == GameState.PROCESSING.Id)
            {
                return ResultHelper.Fail("进行中的比赛不能取消");
            }
            //状态更新
            var cmd = CommandHelper.CreateProcedure(FetchType.Execute, "sp_SetGameState");
            cmd.Params.Add("@gameId", game.Id);
            cmd.Params.Add("@state", game.State.GetId());
            cmd.CreateParamMsg();
            var result = DbContext.GetInstance().Execute(cmd);
            ///////////////////////////////////////////////////////////////////////
            if (result.IsSuccess)//假如是赛事正常结束状态,则更新选中团体模板的使用数量
            {
                bool flag = false;
                if (result.OutParams.Count <= 0)
                {
                    flag = true;
                }
                else
                {
                    string outValue = result.OutParams[0].value.ToString();
                    if (string.IsNullOrEmpty(outValue))
                        flag = true;
                }
                if (game.State == GameState.FINISH.Id)//比赛结束时 015005 ,更改模板使用次数
                {
                    
                    
                    if (flag)//假如输出参数有值,则表示不能结束比赛,不更新模板次数
                    {
                        var cmd2 = CommandHelper.CreateText<Game>(FetchType.Fetch, "SELECT TeamMode FROM Game WHERE Id=@gameId");
                        cmd2.Params.Add("@gameId", game.Id);
                        var res2 = DbContext.GetInstance().Execute(cmd2);
                        string templetId = (res2.Entities[0] as Game).TeamMode;//模板ID
                        if (!string.IsNullOrEmpty(templetId))
                            GameLoopTempletHelper.UpdateTempletUseCount(templetId, "");
                    }
                    
                }
                ///////////////////////////////////////////////////////////////////////////////////////
                try
                {
                    if (flag)//根据返回输出参数判断,是否能更改状态,不空为不能更改
                    {
                        var state = GameState.Find(game.State.GetId());
                        var msg = string.Format("您参加的[{0}] 比赛[{1}]。", game.Name, state.Name);
                        JPushHelper.SendNotify(MasterType.GAME.Id, game.Id, msg, GameHelper.GetAllUserIdList(game.Id));
                    }

                }
                catch (Exception)
                {
                }
            }
            
            return result;
        }
    }
}
