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
    /// 获取大课介绍信息
    /// </summary>
    public class GetCoachBigCourseInfo_186 : IService
    {
        public Response Execute(string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetSystemManageRelatedFilter>>(request);
            var sql = @"
SELECT  * FROM  dbo.CoachBigCourseInfo WHERE Id=@BigCourseInfoId
";
            var cmd = CommandHelper.CreateText<CoachBigCourseInfo>(FetchType.Fetch, sql);
            cmd.Params.Add("@BigCourseInfoId", req.Filter.BigCourseInfoId);
            var result = DbContext.GetInstance().Execute(cmd);
            foreach (var item in result.Entities)
            {
                if (item!=null)
                {
                    var obj=item as CoachBigCourseInfo;
                    obj.TryGetFiles();
                }
            }
            return result;

        }


    }
}
