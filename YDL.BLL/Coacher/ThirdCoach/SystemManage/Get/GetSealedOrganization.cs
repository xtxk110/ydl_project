using System;
using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Core;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 获取封闭机构详情
    /// </summary>
    public class GetSealedOrganization_189 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetCoachRelatedFilter>>(request);
            Response rsp = ResultHelper.CreateResponse();
            CoachOrganization obj = new CoachOrganization();
            if (!string.IsNullOrEmpty(req.Filter.SealedOrganizationManagerId))
            {
                obj = getOrgByManagerId(req.Filter.SealedOrganizationManagerId);
            }
            if (!string.IsNullOrEmpty(req.Filter.CoachId))
            {
                obj = getOrgByCoachId(req.Filter.CoachId);
            }
            else if (!string.IsNullOrEmpty(req.Filter.SealedOrganizationId))
            {
                obj = getOrgById(req.Filter.SealedOrganizationId);
            }
            //人员统计
            SetCoachCount(obj);
            SetStudentCount(obj);
            SetCourseCount(obj);
            rsp.Entities.Add(obj);
            return rsp;

        }

        public void SetCoachCount(CoachOrganization obj)
        {

            var sql = @"

SELECT 
	COUNT(Id) AS CoachCount
FROM dbo.Coach
WHERE SealedOrganizationId=@SealedOrganizationId

";
            var cmd = CommandHelper.CreateText<CoachOrganization>(FetchType.Fetch, sql);
            cmd.Params.Add("@SealedOrganizationId", obj.Id);
            var result = DbContext.GetInstance().Execute(cmd);
            var objCount = result.FirstEntity<CoachOrganization>();
            obj.CoachCount = objCount.CoachCount;
        }

        public void SetStudentCount(CoachOrganization obj)
        {

            var sql = @"
SELECT 
	COUNT(DISTINCT StudentId) AS StudentCount
FROM dbo.CoachBootcampStudent
WHERE SealedOrganizationId=@SealedOrganizationId

";
            var cmd = CommandHelper.CreateText<CoachOrganization>(FetchType.Fetch, sql);
            cmd.Params.Add("@SealedOrganizationId", obj.Id);
            var result = DbContext.GetInstance().Execute(cmd);
            var objCount = result.FirstEntity<CoachOrganization>();
            obj.StudentCount = objCount.StudentCount;
        }

        public void SetCourseCount(CoachOrganization obj)
        {

            var sql = @"
SELECT 
	COUNT(Id) AS CourseCount
FROM dbo.CoachBootcampCourse  
WHERE SealedOrganizationId=@SealedOrganizationId

";
            var cmd = CommandHelper.CreateText<CoachOrganization>(FetchType.Fetch, sql);
            cmd.Params.Add("@SealedOrganizationId", obj.Id);
            var result = DbContext.GetInstance().Execute(cmd);
            var objCount = result.FirstEntity<CoachOrganization>();
            obj.CourseCount = objCount.CourseCount;
        }

        /// <summary>
        /// 查询教练所属机构详情
        /// </summary>
        /// <param name="orgId"></param>
        /// <returns></returns>
        public CoachOrganization getOrgByCoachId(string coachId)
        {
            var sql = @"
  SELECT 
	 a.*,
	 ManagerName =dbo.fn_GetUserName(b.Id)
 FROM dbo.CoachOrganization a
 INNER JOIN dbo.Coach c ON c.SealedOrganizationId=a.Id
 LEFT JOIN dbo.UserAccount b ON c.Id=b.Id
 WHERE 
	c.Id =@coachId 
";
            var cmd = CommandHelper.CreateText<CoachOrganization>(FetchType.Fetch, sql);
            cmd.Params.Add("@coachId", coachId);
            var result = DbContext.GetInstance().Execute(cmd);
            var obj = result.FirstEntity<CoachOrganization>() ?? new CoachOrganization();
            return obj;
        }

        public CoachOrganization getOrgById(string orgId)
        {
            var sql = @"
 SELECT 
	 a.*,
	 ManagerName =(CASE WHEN ISNULL(b.CardName,'')='' THEN b.PetName ELSE b.CardName END )
 FROM dbo.CoachOrganization a
 LEFT JOIN dbo.UserAccount b ON a.ManagerId=b.Id
 WHERE 
	a.Id =@Id 
";
            var cmd = CommandHelper.CreateText<CoachOrganization>(FetchType.Fetch, sql);
            cmd.Params.Add("@Id", orgId);
            var result = DbContext.GetInstance().Execute(cmd);
            var obj = result.FirstEntity<CoachOrganization>() ?? new CoachOrganization();
            return obj;
        }


        public CoachOrganization getOrgByManagerId(string CurrentUserId)
        {
            var sql = @"
 SELECT 
	 a.*,
	 ManagerName =(CASE WHEN ISNULL(b.CardName,'')='' THEN b.PetName ELSE b.CardName END )
 FROM dbo.CoachOrganization a
 LEFT JOIN dbo.UserAccount b ON a.ManagerId=b.Id
 WHERE 
	a.ManagerId LIKE '%" + CurrentUserId + @"%' AND a.OrgType='Sealed'

";
            var cmd = CommandHelper.CreateText<CoachOrganization>(FetchType.Fetch, sql);
            cmd.Params.Add("@ManagerId", CurrentUserId);
            var result = DbContext.GetInstance().Execute(cmd);
            var obj = result.FirstEntity<CoachOrganization>() ?? new CoachOrganization();
            return obj;
        }


        //        public int GetCoachCount()
        //        {

        ////            var sql = @"
        ////SELECT 
        ////	COUNT(Id) AS CoachCount
        ////FROM dbo.Coach 
        ////WHERE SealedOrganizationId=@SealedOrganizationId
        ////";
        ////            var cmd = CommandHelper.CreateText<Coacher>(FetchType.Fetch, sql);
        ////            cmd.Params.Add("@userId", req.Filter.UserId);
        ////            var result = DbContext.GetInstance().Execute(cmd);
        ////            return result;
        //        }



    }
}
