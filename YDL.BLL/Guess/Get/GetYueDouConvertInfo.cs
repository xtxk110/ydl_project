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
    /// 获取悦豆兑换比例
    /// </summary>
    public class GetYueDouConvertInfo_188 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            Response response = ResultHelper.CreateResponse();
            response.IsSuccess = true;
            response.Tag = UserHelper.GetConfig().YueDouConvertibleProportion;
            return response;
        }


    }
}
