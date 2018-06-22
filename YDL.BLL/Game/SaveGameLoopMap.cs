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
    /// 保存对阵映射关系
    /// </summary>
    public class SaveGameLoopMap : IService
    {
        /// <summary>
        ///  保存对阵映射关系
        /// </summary>
        /// <param name="currentUser">忽略</param>
        /// <param name="request">Request.GameLoopMap</param>
        /// <returns>Response.EmptyEntity</returns>
        public Response Execute(string request)
        {
            var reqAll= JsonConvert.DeserializeObject<Request<GameLoopMapNew>>(request);
            var mapNew = reqAll.Entities[0] as GameLoopMapNew;
            //检查规则编码对应的人员是否重复
            if (GameLoopTempletHelper.IsSame(mapNew.TempletMapList))
                return ResultHelper.Fail("对阵人员不能重复");

            //var req = JsonConvert.DeserializeObject<Request<GameLoopMap>>(request);
            var loopMapList = mapNew.LoopMapList; ;
            //var firstMap = req.FirstEntity();
            var firstMap = loopMapList[0];
            List<EntityBase> list = new List<EntityBase>();
            foreach (var obj in loopMapList)
            {

                obj.Team1Id = obj.Team1Id.GetId();
                obj.Team2Id = obj.Team2Id.GetId();
                //if (obj.RowState == RowState.Added)
                //{
                //    obj.SetNewId();
                //    obj.SetCreateDate();
                //}
                obj.SetNewEntity();
                list.Add(obj);
            }

            var cmd = CommandHelper.CreateSave(list);

            //删除映射及比赛详情  先删除规则队员映射关系
            var cmdDelete = CommandHelper.CreateText(FetchType.Execute);
            //cmdDelete.Text = "DELETE FROM dbo.GameLoopMap WHERE LoopId=@loopId  DELETE FROM dbo.GameLoopDetail WHERE LoopId=@loopId ";
            cmdDelete.Text = "DELETE FROM dbo.GameLoopMap WHERE LoopId=@loopId  DELETE FROM dbo.GameLoopDetail WHERE LoopId=@loopId  DELETE FROM GameTeamLoopTempletMap WHERE LoopId=@loopId";
            cmdDelete.Params.Add("@loopId", firstMap.LoopId);
            cmd.PreCommands = new List<Command> { cmdDelete };
            var res= DbContext.GetInstance().Execute(cmd);

            //////////////////保存模板规则队员映射关系/////////////////
            if (res.IsSuccess)
            {
                list.Clear();
                cmdDelete = null;
                cmd = null;
                foreach (var item in mapNew.TempletMapList)
                {
                    item.SetNewEntity();
                    list.Add(item);
                }
                cmd = CommandHelper.CreateSave(list);
                res = DbContext.GetInstance().Execute(cmd);
            }

            //

            /*
            var firstMap = req.FirstEntity();
            if (firstMap.SaveMapOption == "1")
            {
                cmd.OnlyFields = new List<TableFieldPair> { new TableFieldPair { Table = "GameLoopMap", Fields = "Team1Id,User1Id,User1Name" } };
            }
            else if (firstMap.SaveMapOption == "2")
            {
                cmd.OnlyFields = new List<TableFieldPair> { new TableFieldPair { Table = "GameLoopMap", Fields = "Team2Id,User2Id,User2Name" } };
            }*/
            return res;
        }
    }
}
