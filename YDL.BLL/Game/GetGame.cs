
using System.Collections.Generic;
using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Utility;
using YDL.Core;

namespace YDL.BLL
{
    /// <summary>
    /// 获取赛事详情
    /// </summary>
    public class GetGame : IServiceBase
    {

        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<Game>>(request);
            var cmd = CommandHelper.CreateProcedure<Game>(text: "sp_GetGame");
            cmd.Params.Add(CommandHelper.CreateParam("@userId", currentUser.Id));
            cmd.Params.Add(CommandHelper.CreateParam("@gameId", req.Filter.Id));

            var result = DbContext.GetInstance().Execute(cmd);
            if (result.Entities.IsNotNullOrEmpty())
            {
                var game = result.FirstEntity<Game>();
                SetHeadAndFiles(game);
                GameHelper.SetGameTeamList(game);
                game.SocketIpAndPort = UserHelper.GetConfig().IntranetSocketIpAndPort;//返回局域网内的地址
                game.IsInLive = LiveHelper.Instance.IsInLive(game.Id);
                game.IsAudit = game.AuditId==null||!game.AuditId.Contains(currentUser.Id) ? false : true;
                game.IsManage = game.ManageId==null||!game.ManageId.Contains(currentUser.Id) ? false : true;
                game.AuditName = UserHelper.GetMultiUserName(game.AuditId);//返回名称
                game.ManageName = UserHelper.GetMultiUserName(game.ManageId);
                game.WinGameArr = new int[] { 2, 3, 4 };//小局胜局数
            }

            return result;
        }

        public static void SetHeadAndFiles(Game game)
        {
            game.HeadUrlOld = game.HeadUrl;
            game.TryGetFiles();
        }
    }


    public class GetGame2 : IService
    {
        public Response Execute(string request)
        {
            var req = JsonConvert.DeserializeObject<Request<Game>>(request);
            var cmd = CommandHelper.CreateProcedure<Game>(text: "sp_GetGame");
            cmd.Params.Add(CommandHelper.CreateParam("@userId", "tourist"));
            cmd.Params.Add(CommandHelper.CreateParam("@gameId", req.Filter.Id));

            var result = DbContext.GetInstance().Execute(cmd);
            if (result.Entities.IsNotNullOrEmpty())
            {
                var game = result.FirstEntity<Game>();  
                GetGame.SetHeadAndFiles(game);
                GameHelper.SetGameTeamList(game);
                game.SocketIpAndPort = UserHelper.GetConfig().IntranetSocketIpAndPort;//返回局域网内的地址
            }

            return result;
        }
    }

}
