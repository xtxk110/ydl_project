using System.Linq;
using System.Configuration;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using RestSharp;
using System;
using YDL.Utility;
using System.Threading.Tasks;
using System.Threading;
using System.Dynamic;

namespace YDL.BLL
{
    /// <summary>
    /// 设置IM用户资料
    /// </summary>
    public class SavePeopleInfo : IServiceBase
    {
        /// <summary>
        /// 设置IM用户资料
        /// </summary>
        /// <param name="currentUser"></param>
        /// <param name="request"></param>
        /// <returns></returns>
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<PeopleInfo>(request);

            var reqRest = new RestRequest("v4/profile/portrait_set", Method.POST);
            var peopleInfo = new PeopleSetInfo();
            peopleInfo.From_Account = "";
            peopleInfo.ProfileItem.Add(new PeopleSetInfoItem 
            { Tag = "Tag_Profile_IM_Nick", Value = "" }); //昵称
            peopleInfo.ProfileItem.Add(new PeopleSetInfoItem
            { Tag = "Tag_Profile_IM_Image", Value = "" }); //头像URL
            peopleInfo.ProfileItem.Add(new PeopleSetInfoItem
            { Tag = "Tag_Profile_IM_AllowType", Value = FriendAllowType.AllowType_Type_NeedConfirm.ToString() });//加好友验证方式
            peopleInfo.ProfileItem.Add(new PeopleSetInfoItem
            { Tag = "Tag_Profile_IM_SelfSignature", Value = "" }); //个性签名

            reqRest.AddJsonBody(peopleInfo);

            var rsp = RestApiHelper.SendIMRequest<IMMessageResult>(reqRest);
            return new Response() { IsSuccess = rsp.Data.ErrorCode == 0, Message = rsp.Data.ErrorInfo };

        }

        public enum FriendAllowType
        {
            AllowType_Type_NeedConfirm,//表示需要经过自己确认才能添加自己为好友
            AllowType_Type_AllowAny, //表示允许任何人添加自己为好友
            AllowType_Type_DenyAny //表示不允许任何人添加自己为好友
        }
    }
}
