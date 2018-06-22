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
    /// 获取集训在首页显示
    /// </summary>
    public class GetCoachBootcampForHomePage : IService
    {
        public Response Execute(string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetSystemManageRelatedFilter>>(request);
            var sql = @"
            SELECT
               TOP 5 *
            FROM dbo.CoachBootcamp
			WHERE State='Join' 
                        AND EndTime>GETDATE()
                        AND (SealedOrganizationId = '' OR SealedOrganizationId IS NULL)
            ORDER BY  State DESC ,UpdateDate DESC 
";
            var cmd = CommandHelper.CreateText<CoachBootcamp>(FetchType.Fetch, sql);
            var result = DbContext.GetInstance().Execute(cmd);
            result.IsSuccess = true;
            if (result.Entities.Count==0)
            {
                result.Entities = new List<EntityBase>();
            }

            return result;


        }



    }
}
