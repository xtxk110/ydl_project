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
    /// 获取团体比赛时候，某一场比赛，每个队伍每个出场队员对阵列表
    /// </summary>
    public class GetGameLoopMapList : IService
    {
        /// <summary>
        /// 获取团体比赛时候，某一场比赛，每个队伍每个出场队员对阵列表
        /// </summary>
        /// <param name="currentUser">忽略</param>
        /// <param name="request">Request.GameLoop.Filter</param>
        /// <returns>Response.GameLoopMap</returns>
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GameLoop>>(request);
            var cmd = CommandHelper.CreateProcedure<GameLoopMap>(text: "sp_GetGameLoopMapList");
            cmd.Params.Add(CommandHelper.CreateParam("@loopId", req.Filter.Id));

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();

            var order = GameHelper.GetGameOrderByLoop(req.Filter.Id);
            result.Tag = JsonConvert.SerializeObject(order);

            SetGameLoopMapDetailList(result);

            return result;
        }

        private static void SetGameLoopMapDetailList(Response result)
        {
            if (result.Entities.IsNotNullOrEmpty())
            {
                foreach (GameLoopMap obj in result.Entities)
                {
                    //获取队员的技能积分
                    obj.User1Score = GameHelper.GetSportScoreByUser(obj.User1Id);
                    obj.User2Score = GameHelper.GetSportScoreByUser(obj.User2Id);


                    var filter = new GetGameLoopDetailListFilter
                    {
                        LoopId = obj.LoopId,
                        MapId = obj.Id
                    };
              
           
                    var detailList = GameHelper.GetGameLoopDetailList(filter).Entities;
                    if (detailList.IsNotNullOrEmpty())
                    {
                       
                        obj.DetailList = detailList.ToList<EntityBase, GameLoopDetail>();
                        
                    }
                    //获取头像
              
                    GetUserHeadUrl(obj);
                }
            }
        }

        public static void GetUserHeadUrl(GameLoopMap item)
        {
            //获取 user1HeadUrl
            if(item.User1Id != null)
            {
                string[] user1IdList = item.User1Id.Split(',');
                foreach (var user1Id in user1IdList)
                {
                    item.User1HeadUrl += UserHelper.GetUserById(user1Id).HeadUrl + ",";
                }
                item.User1HeadUrl = item.User1HeadUrl.Trim(',');
            }
            
            //获取 user2HeadUrl
            if(item.User2Id != null)
            {
                string[] user2IdList = item.User2Id.Split(',');

                foreach (var user2Id in user2IdList)
                {
                    item.User2HeadUrl += UserHelper.GetUserById(user2Id).HeadUrl + ",";
                }
                item.User2HeadUrl = item.User2HeadUrl.Trim(',');
            }
        }

    }
}
