using System;
using System.Linq;
using System.Collections.Generic;

using Newtonsoft.Json;
using YDL.Core;
using YDL.Map;
using YDL.Model;
using YDL.Utility;
using RestSharp;

namespace YDL.BLL
{
    /// <summary>
    /// 设置或取消全员禁言 (全员禁言后管理员和群主可以聊天)
    /// </summary>
    public class SetOrCancelAllShutup : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<IMGroup>>(request);
            var obj = req.Entities.FirstOrDefault();
            var userCodeListArray = GetClubUserList(obj.GroupId);
            Response result = new Response();
            foreach (var item in userCodeListArray)//循环一次取500个群成员,如果有500人以上,会循环2次以上
            {
                //请求IM接口
                obj.Members_Account.AddRange(item);
                var reqRest = new RestRequest("v4/group_open_http_svc/forbid_send_msg", Method.POST);
                reqRest.AddJsonBody(obj);
                result = RestApiHelper.SendIMRequestAndGetResponse(reqRest);
                if (result.IsSuccess == false)
                {
                    break;
                }
                obj.Members_Account.Clear();
            }
            if (userCodeListArray.Count==0)
            {
                return ResultHelper.Fail("没有可以禁言的成员");// 即没有获取到普通用户, 此时群里只有管理员或者创建者
            }
            return result;

        }

        /// <summary>
        /// 获取普通用户(管理员创建者除外) code
        /// </summary>
        /// <param name="clubId"></param>
        /// <returns></returns>
        public List<List<string>> GetClubUserList(string clubId)
        {
            var sql = @"
 SELECT 
	b.Code AS UserCode
 FROM dbo.ClubUser a
 INNER JOIN dbo.UserAccount b ON a.UserId=b.Id
 WHERE 
	a.ClubId=@ClubId 
	AND a.IsAdmin=0 AND a.IsCreator=0
";
            var cmd = CommandHelper.CreateText<ClubUser>(FetchType.Fetch, sql);
            cmd.Params.Add("@ClubId", clubId);
            var result = DbContext.GetInstance().Execute(cmd);
            var list = result.Entities.ToList<EntityBase, ClubUser>();
            var codeList = new List<string>();
            List<List<string>> codeListArray = new List<List<string>>();
            int i = 0;
            foreach (var item in list)
            {
                i++;
                codeList.Add(item.UserCode);

                if (i < 499 && i == list.Count)
                {
                    codeListArray.Add(codeList);
                }
                if (i == 499)//因为腾讯Im最大接受500, 所以得分组, 哎, fuck
                {
                    codeListArray.Add(codeList);
                    codeList = null;
                    codeList = new List<string>();//重置
                    i = 0;//重置
                }
            
               
            }
            return codeListArray;

        }


    }

}
