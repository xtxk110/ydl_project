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
    /// 获取集训列表
    /// </summary>
    public class GetCoachBootcampList : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetSystemManageRelatedFilter>>(request);

            if (CoachHelper.Instance.IsSealedOrgStudent(currentUser.Id))
            {
                //封闭机构的学员即出悦动力的集训也出封闭机构的
                var cmd = CommandHelper.CreateProcedure<CoachBootcamp>(text: "sp_GetCoachBootcampList");
                cmd.Params.Add("IsForSyllabus", req.Filter.IsForSyllabus);
                cmd.CreateParamPager(req.Filter);

                var result = DbContext.GetInstance().Execute(cmd);
                result.SetRowCount();
                foreach (var item in result.Entities)
                {
                    var obj = item as CoachBootcamp;
                    if (string.IsNullOrEmpty(obj.SealedOrganizationId))
                    {
                        obj.BootcampType =CoachDic.Bootcamp_YDL;
                    }
                    else
                    {
                        obj.BootcampType = CoachDic.Bootcamp_Sealed;
                    }
                }

                return result;
            }
            else
            {
                //普通学员仅出悦动力的集训
                var sql = @"

SELECT 
    a.*,
    'YDL' AS BootcampType
FROM dbo.CoachBootcamp a
WHERE a.SealedOrganizationId IS NULL OR a.SealedOrganizationId=''
";
                var cmd = CommandHelper.CreateText<CoachBootcamp>(FetchType.Fetch, sql);
                var result = DbContext.GetInstance().Execute(cmd);
                return result;
            }


        }





    }
}
