
using Newtonsoft.Json;
using System;
using System.Configuration;
using System.Security.Cryptography;
using System.Text;
using YDL.Core;
using YDL.Map;
using YDL.Model;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 获取房间列表
    /// </summary>
    public class GetLiveRoomList_192 : IServiceBase
    {


        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetLiveRelatedFilter>>(request);
            var cmd = CommandHelper.CreateProcedure<LiveRoom>(text: "sp_GetLiveRoomList");
            cmd.Params.Add(CommandHelper.CreateParam("@GameId", req.Filter.GameId));
            cmd.CreateParamPager(req.Filter);

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();
            foreach (var item in result.Entities)
            {
                var obj = item as LiveRoom;
                if (!string.IsNullOrEmpty(obj.VsGameLoopId))
                {
                    obj.VSDetail = LiveHelper.Instance.GetVSDetail(obj.VsOrderId, obj.VsGameLoopId);
                }

                
                //假如是点播视频,则PlayUrl变为对应的点播视频地址
                if (obj.IsVod)//点播更改地址
                {
                    obj.PlayUrl = obj.VodPlayUrl;
                }
                else
                {
                    User user = UserHelper.GetUserById(obj.AnchorId);
                    if (user != null)
                    {
                        string play = LiveHelper.Instance.GetPlayUrl(user.Code, obj.IsThirdparty);
                        obj.PlayUrl = play.Substring(0, play.IndexOf('?')) + @".flv";//直播地址
                        //obj.SharePlayUrl = LiveHelper.Instance.GetShareUrl(obj.PlayUrl);//获取直播分享地址
                    }
                }
            }
            return result;
        }


    }

}
