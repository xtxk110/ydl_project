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
using YDL.Core;
using System.Collections.Generic;

namespace YDL.BLL
{
    /// <summary>
    /// 导入俱乐部到腾讯IM群
	/// 文档：https://www.qcloud.com/document/product/269/1615
    /// </summary>
    public class ImportClub : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetIMRelatedFilter>>(request);
            Response rsp = new Response();
            rsp =IMHelper.Instance.ImportExistClubToIMGroup(req.Filter.ClubId);
            //if (rsp.Message == "group id has be used!")
            //{
            //    continue ;
            //}

            //if (rsp.Message == "group name is too long" || rsp.Message == "introduction is too long")
            //{
            //    nameTooLong.Add(item);
            //    continue;
            //}

            return rsp;
        }

       
    }
}
