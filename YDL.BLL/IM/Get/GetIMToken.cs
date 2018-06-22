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
using System.Collections.Generic;
using YDL.Core;

namespace YDL.BLL
{
    /// <summary>
    ///根据IM Identifier 获取此用户的 UserSig
    /// </summary>
    public class GetIMToken : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetIMRelatedFilter>>(request);
            Response rsp = new Response();
            try {
                
                rsp.IsSuccess = true;
                rsp.Entities = new List<EntityBase>();
                IMToken token = new IMToken();
                token.UserSig = IMUserSig.GetUserSig(req.Filter.Identifier);
                token.Sdkappid = IMRequest.sdkappid;
                token.AccountType = IMRequest.AccountType;

                rsp.Entities.Add(token);
                
            }catch(Exception e) { }
            return rsp;
        }
    }
}
