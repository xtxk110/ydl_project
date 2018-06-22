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
    /// 获取教学点列表
    /// </summary>
    public class GetTeachingPointList : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetSystemManageRelatedFilter>>(request);
            var cmd = CommandHelper.CreateProcedure<TeachingPoint>(text: "sp_GetTeachingPointList");
            cmd.Params.Add(CommandHelper.CreateParam("@venueName", req.Filter.VenueName));
            cmd.Params.Add(CommandHelper.CreateParam("@isOnlyTeachingPoint", req.Filter.IsOnlyTeachingPoint));
            cmd.CreateParamPager(req.Filter);

            var result = DbContext.GetInstance().Execute(cmd);
            foreach (var item in result.Entities)
            {
                TeachingPoint obj = item as TeachingPoint;
                obj.CoacherNames = obj.CoacherNames.Trim('、');
                obj.CoacherIds = obj.CoacherIds.Trim(',');
                obj.CoacherUserList = GetCoachUserList(obj.CoacherIds);
            }


            result.SetRowCount();

            return result;

        }

        public List<User> GetCoachUserList(string coachIds)
        {
            //组装Id
            var idsArray = coachIds.Split(',');
            string ids = "";
            foreach (var item in idsArray)
            {
                ids += "'" + item + "',";
            }
            ids = ids.Trim(',');
            //执行sql
            var sql = @"
SELECT 
	b.Id,
	dbo.fn_GetUserName(b.Id) AS CardName,
	b.Sex,
	b.HeadUrl 
FROM dbo.Coach a
INNER JOIN dbo.UserAccount b ON a.Id=b.Id
WHERE b.Id IN (" + ids + @")
";
            var cmd = CommandHelper.CreateText<User>(FetchType.Fetch, sql);
            var result = DbContext.GetInstance().Execute(cmd);
            return result.Entities.ToList<EntityBase, User>();

        }


    }
}
