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
    /// 获取某一场比赛各小局列表
    /// </summary>
    public class GetGameLoopDetailList : IService
    {
        /// <summary>
        /// 获取某一场比赛各小局列表
        /// </summary>
        /// <param name="currentUser">忽略</param>
        /// <param name="request">Request.GetGameLoopDetailListFilter.Filter</param>
        /// <returns>Response.GameLoopDetail</returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetGameLoopDetailListFilter>>(request);
            var result = GameHelper.GetGameLoopDetailList(req.Filter);
            if (result.Entities.Count == 0)//假如数据为空,则根据GameOrder表WinGame胜局字段生成局数
            {
                var entities = CreateLoopDetail(req.Filter.LoopId, req.Filter.MapId);
                if (entities.Count > 0)
                {
                    GameLoopDetail detail = entities[0] as GameLoopDetail;
                    bool isTeam = string.IsNullOrEmpty(req.Filter.MapId) ? false : true;
                    int detailLoopCount = detail.WinGame * 2 - 1;//对阵总局数
                    List<EntityBase> resultEntity = new List<EntityBase>();
                    for(int i = 1; i <= detailLoopCount; i++)
                    {
                        GameLoopDetail newDetail = new GameLoopDetail { Id = Ext.NewId(), LoopId = req.Filter.LoopId, MapId = req.Filter.MapId, IsTeam = isTeam,
                                                    Team1Id = detail.Team1Id,User1Id=detail.User1Id,Team2Id=detail.Team2Id,User2Id=detail.User2Id
                                                    ,OrderNo=i,CreateDate=DateTime.Now
                        };
                        newDetail.RowState = RowState.Added;
                        resultEntity.Add(newDetail);
                    }
                    var res = DbContext.GetInstance().Execute(CommandHelper.CreateSave(resultEntity));
                    if(res.IsSuccess)
                        result.Entities = resultEntity;
                }
            }
            return result;
        }

        public List<EntityBase> CreateLoopDetail(string loopId,string mapId)
        {
            string fieldStr = string.Empty;
            string joinStr = string.Empty;
            if (string.IsNullOrEmpty(mapId))
            {
                fieldStr = ",c.TeamUserId AS User1Id,d.TeamUserId AS User2Id ";
                joinStr = " LEFT JOIN GameTeam AS c ON b.Team1Id=c.Id LEFT JOIN GameTeam AS d ON b.Team2Id=d.Id ";
            }
            else
            {
                fieldStr = ",c.User1Id,c.User2Id ";
                joinStr = " LEFT JOIN GameLoopMap AS c ON c.Id='" + mapId + "'";
            }
            string sql= @"SELECT a.WinGame,b.Team1Id,b.Team2Id "+fieldStr+" FROM GameOrder AS a INNER JOIN GameLoop AS b ON a.Id=b.OrderId "+joinStr+" WHERE b.Id = @loopId ";

            Command cmd = CommandHelper.CreateText<GameLoopDetail>(FetchType.Fetch, sql);
            cmd.Params.Add("@loopId", loopId);
            Response rsp = DbContext.GetInstance().Execute(cmd);
            return rsp.Entities;
        }
    }

}
