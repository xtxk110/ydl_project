using System;
using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Core;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 获取某大轮次下面所有比赛场次，正赛/附加赛
    /// </summary>
    public class GetGameOrderLoopList : IService
    {
        /// <summary>
        /// 获取某大轮次下面所有比赛场次，正赛/附加赛
        /// </summary>
        /// <param name="request">Request.GetGameOrderLoopListFilter.Filter</param>
        /// <returns>Response.GameLoop</returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetGameOrderLoopListFilter>>(request);
            if (string.IsNullOrEmpty(req.Filter.GameId))
                return ResultHelper.Fail("赛事ID未上传");
            Command cmd = null;
            if (req.Filter.PageIndex<=0)
                cmd = CommandHelper.CreateProcedure<GameLoop>(text: "sp_GetGameOrderLoopList");
            else
            {
                cmd = CommandHelper.CreateProcedure<GameLoop>(text: "sp_GetGameOrderLoopListPage");
                cmd.CreateParamPager(req.Filter);
            }

            cmd.Params.Add(CommandHelper.CreateParam("@gameId", req.Filter.GameId));
            cmd.Params.Add(CommandHelper.CreateParam("@knockOutAB", req.Filter.KnockOutAB));
            cmd.Params.Add(CommandHelper.CreateParam("@orderId", req.Filter.OrderId));
            cmd.Params.Add(CommandHelper.CreateParam("@groupId", req.Filter.GroupId));
            cmd.Params.Add(CommandHelper.CreateParam("@isExtra", req.Filter.IsExtra));
            cmd.Params.Add(CommandHelper.CreateParam("@groupOrderNo", req.Filter.GroupOrderNo));
            cmd.Params.Add(CommandHelper.CreateParam("@orderNo", req.Filter.OrderNo));

            cmd.Params.Add(CommandHelper.CreateParam("@startTime", req.Filter.StartTime));
            string endTime = req.Filter.EndTime;
            if (!string.IsNullOrEmpty(endTime))
                endTime = DateTime.Parse(endTime).AddDays(1).ToString("yyyy-MM-dd");

            cmd.Params.Add(CommandHelper.CreateParam("@endTime", endTime));
            cmd.Params.Add(CommandHelper.CreateParam("@team1Id", req.Filter.Team1Id));
            if (req.Filter.Team1Id== req.Filter.Team2Id)
            {
                cmd.Params.Add(CommandHelper.CreateParam("@team2Id", ""));
            }
            else
            {
                cmd.Params.Add(CommandHelper.CreateParam("@team2Id", req.Filter.Team2Id));
            }
            
            cmd.Params.Add(CommandHelper.CreateParam("@tableNo", req.Filter.TableNo));
            

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();
            GetGameLoopDetailListFilter detailFilter = new GetGameLoopDetailListFilter();//查询每次对阵的小局详情模型
            foreach (var item in result.Entities)
            {
                GameLoop gl = item as GameLoop;
                if (gl.IsTeam)
                {
                    gl.DetailList = GameHelper.GetLoopMapByLoop(gl.Id);//取LOOPMAP里的大分数据
                }
                else
                {
                    detailFilter.LoopId = gl.Id;
                    try
                    {
                        var tempResut = GameHelper.GetGameLoopDetailList(detailFilter).Entities;
                        gl.DetailList = tempResut.ToList<EntityBase, GameLoopDetail>();

                    }
                    catch { }
                }

            }

            return result; 
        }

    }

    
}
