using System;
using System.Linq;
using System.Collections.Generic;
using System.Configuration;
using Newtonsoft.Json;
using YDL.Core;
using YDL.Map;
using YDL.Model;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 保存房间信息
    /// </summary>
    public class SaveLiveRoom_192 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<LiveRoom>>(request);
            var obj = req.FirstEntity();

            List<EntityBase> entites = new List<EntityBase>();
            entites.Add(obj);

            if (obj.RowState != RowState.Deleted)
            {
                if (obj.IsThirdparty)
                    obj.State = LiveDic.Active;
                else
                    obj.State = LiveDic.UnActive;

                //判断此人的直播间是否存在
                var sql = @"SELECT * FROM LiveRoom WHERE AnchorId=@userId;";
                var cmd = CommandHelper.CreateText<LiveRoom>(FetchType.Fetch, sql);
                cmd.Params.Add("@userId", obj.AnchorId);
                var existResult = DbContext.GetInstance().Execute(cmd);
                var existObj = existResult.FirstEntity<LiveRoom>();
                if (existObj != null)
                {
                    obj.RowState = RowState.Modified;
                    obj.Id = existObj.Id;
                    if(!obj.IsThirdparty)
                        obj.State = existObj.State;//假如是修改,直播状态以上传的为准
                    obj.SetCreateDate();
                }
                else
                {
                    obj.RowState = RowState.Added;
                    obj.TrySetNewEntity();
                }


                //注意以下两行代码要一起拷贝, 不然会出现莫名其妙的图片问题
                //处理头像
                obj.ModifyHeadIcon();
                //获取将要保存的图片列表
                obj.GetWillSaveFileList(entites);
            }
           


            var result = DbContext.GetInstance().Execute(CommandHelper.CreateSave(entites));
            if (obj.RowState != RowState.Deleted)
            {
                result.Tag = LiveHelper.Instance.GetPushUrl(currentUser.Code, obj.IsThirdparty);//直播推流URL
                User user = UserHelper.GetUserById(obj.AnchorId);
                if (user != null)
                {
                    string playUrl = LiveHelper.Instance.GetPlayUrl(user.Code, obj.IsThirdparty);
                    string liveShareUrl = string.IsNullOrEmpty(ConfigurationManager.AppSettings["LIVE_SHARE_URL"])? "https://lvbs.cloud.tencent.com/live/play.html" : ConfigurationManager.AppSettings["LIVE_SHARE_URL"];
                    string m3u8ShareUrl = LiveHelper.Instance.GetShareUrl(playUrl,1);//m3u8播放地址
                    string flvShareUrl = LiveHelper.Instance.GetShareUrl(playUrl, 2);//flv播放地址
                    //obj.SharePlayUrl=LiveHelper.Instance.GetShareUrl(playUrl);//获取直播分享地址
                    result.Tag1 = liveShareUrl+"?url="+m3u8ShareUrl+ "&url1=" + flvShareUrl;//获取直播分享地址 
                }
                    
                result.Entities.Add(obj);
            }
            return result;

        }
        
    }

}
