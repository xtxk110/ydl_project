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
    /// 获取教练详细信息(包括正式教练信息和教练审核信息)
    /// </summary>
    public class GetCoach : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetCoachRelatedFilter>>(request);
            if (string.IsNullOrEmpty(req.Filter.CityId))
            {
                req.Filter.CityId = "75";
            }
            bool isHaveYDLAuditInfo = IsHaveYDLAuditInfo(req.Filter.CoachId);
            //默认查询正式数据
            var sql = @"
SELECT 
	b.HeadUrl,
    b.Sex,
	b.CardName AS Name,
    b.Mobile ,
	Score=dbo.[fn_GetCoachAVGScore] (a.Id),
	a.*,
	c.Address AS VenueAddress,
	c.Lat AS VenueLat,
	c.Lng AS VenueLng,
    d.ManagerId AS OrganizationManagerId,
    c.Id AS VenueId,
    c.Name AS VenueName,
    b.CardId 
FROM dbo.Coach a
INNER JOIN dbo.UserAccount b  ON a.Id=b.Id
LEFT JOIN dbo.CoachOrganization d ON a.OrganizationId=d.Id
LEFT JOIN dbo.Venue c ON a.VenueId=c.Id
WHERE a.Id=@CoachId 
";
            #region 如果是自己查看自己的教练信息-- 如果有审核信息就返回审核信息 --开始
            if (req.Filter.CoachId == currentUser.Id) //自己看自己
            {
                if (isHaveYDLAuditInfo) //有审核信息
                {
                    sql = @"
                    SELECT 
	                    a.HeadUrl,
                        a.CardId,
                        b.Sex,
	                    a.Name ,
                        a.Mobile ,
	                    Score=dbo.[fn_GetCoachAVGScore] (a.Id),
	                    a.*,
	                    c.Address AS VenueAddress,
	                    c.Lat AS VenueLat,
	                    c.Lng AS VenueLng,
                        d.ManagerId AS OrganizationManagerId,
                        c.Id AS VenueId,
                        c.Name AS VenueName
                        
                    FROM dbo.CoachApply a
                    INNER JOIN dbo.UserAccount b  ON a.Id=b.Id
                    LEFT JOIN dbo.CoachOrganization d ON a.OrganizationId=d.Id
                    LEFT JOIN dbo.Venue c ON a.VenueId=c.Id
                    WHERE a.Id=@CoachId ";
                }
            }
            #endregion 如果是自己查看自己的教练信息-- 如果有审核信息就返回审核信息 --结束


            var cmd = CommandHelper.CreateText<Coach>(FetchType.Fetch, sql);
            cmd.Params.Add("@CoachId", req.Filter.CoachId);
            var result = DbContext.GetInstance().Execute(cmd);
            var obj = result.FirstEntity<Coach>();
            if (obj == null)
                return result;
            //教龄
            if (obj.BeginTeachingDate != null && obj.BeginTeachingDate != DateTime.MinValue)
            {
                obj.CoachAge = DateTime.Now.Year - ((DateTime)obj.BeginTeachingDate).Year;
            }

            #region 资质证明文件
            if (req.Filter.CoachId == currentUser.Id && isHaveYDLAuditInfo)
            {
                //自己看自己, 并且有审核信息就返回 审核的资质证明文件
                obj.GetFilesByModule(BusinessType.CoachApply.Id);
            }
            else //其他情况返回正式的 资质证明文件  
            {
                obj.GetFilesByModule(BusinessType.CoachFormal.Id);
            }
            #endregion 资质证明文件

            #region 权限
            //当前登录者是否可以管理此教练
            if (currentUser.Id == "001001" && obj.OrganizationId == CoachDic.YDLCoachOrgId)
            {
                //当前登陆者是系统管理员,而且此教练是悦动力的 才返回true , 才可以管理此教练(比如提升教练等级)
                obj.CurrentUserCanManageThisCoach = true;
            }
            else if (obj.OrganizationManagerId == currentUser.Id)
            {
                //当前登陆者和 此教练所属机构的管理员 是一个人, 才可以管理此教练 (比如提升教练等级)
                obj.CurrentUserCanManageThisCoach = true;
            }
            else
            {
                obj.CurrentUserCanManageThisCoach = false;
            }

            obj.CurrentUserIsCoach = CoachHelper.Instance.IsCoach(currentUser.Id);
            obj.IsHaveYDLAuditInfo = isHaveYDLAuditInfo;
            obj.IsYDLCoach = obj.OrganizationId == CoachDic.YDLCoachOrgId ? true : false;

            #endregion 权限

            //获取教练的单价
            if (!string.IsNullOrEmpty(req.Filter.CityId))
            {
                obj.CoachUnitPrice = CoachHelper.Instance.GetCoachUnitPrice(req.Filter.CityId, obj.Grade);
            }

            return result;

        }



        public bool IsHaveYDLAuditInfo(string coachId)
        {
            string sql = @"
SELECT * FROM dbo.CoachApply WHERE Id=@coachId 
";          //CoachApply 只有两种数据, 一是审核中 , 二是 已拒绝的数据
            var cmd = CommandHelper.CreateText<Coach>(FetchType.Fetch, sql);
            cmd.Params.Add("@coachId", coachId);
            var result = DbContext.GetInstance().Execute(cmd);
            if (result.Entities.Count > 0)
            {
                return true;
            }
            else
            {
                return false;
            }

        }
    }




    /// <summary>
    /// 获取教练详细信息(游客)
    /// </summary>
    public class GetCoach2 : IService
    {
        public Response Execute(string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetCoachRelatedFilter>>(request);
            if (string.IsNullOrEmpty(req.Filter.CityId))
            {
                req.Filter.CityId = "75";
            }

            //默认查询正式数据
            var sql = @"
SELECT 
	b.HeadUrl,
    b.Sex,
	b.CardName AS Name,
    b.Mobile ,
	Score=dbo.[fn_GetCoachAVGScore] (a.Id),
	a.*,
	c.Address AS VenueAddress,
	c.Lat AS VenueLat,
	c.Lng AS VenueLng,
    d.ManagerId AS OrganizationManagerId,
    c.Id AS VenueId,
    c.Name AS VenueName,
    b.CardId 
FROM dbo.Coach a
INNER JOIN dbo.UserAccount b  ON a.Id=b.Id
LEFT JOIN dbo.CoachOrganization d ON a.OrganizationId=d.Id
LEFT JOIN dbo.Venue c ON a.VenueId=c.Id
WHERE a.Id=@CoachId 
";

            var cmd = CommandHelper.CreateText<Coach>(FetchType.Fetch, sql);
            cmd.Params.Add("@CoachId", req.Filter.CoachId);
            var result = DbContext.GetInstance().Execute(cmd);
            var obj = result.FirstEntity<Coach>();
            if (obj == null)
                return result;
            //教龄
            if (obj.BeginTeachingDate != null && obj.BeginTeachingDate != DateTime.MinValue)
            {
                obj.CoachAge = DateTime.Now.Year - ((DateTime)obj.BeginTeachingDate).Year;
            }

            #region 资质证明文件
            else //其他情况返回正式的 资质证明文件  
            {
                obj.GetFilesByModule(BusinessType.CoachFormal.Id);
            }
            #endregion 资质证明文件

            #region 权限

            obj.CurrentUserCanManageThisCoach = false;

            obj.CurrentUserIsCoach = false;
            obj.IsHaveYDLAuditInfo = true;
            obj.IsYDLCoach = obj.OrganizationId == CoachDic.YDLCoachOrgId ? true : false;

            #endregion 权限

            //获取教练的单价
            if (!string.IsNullOrEmpty(req.Filter.CityId))
            {
                obj.CoachUnitPrice = CoachHelper.Instance.GetCoachUnitPrice(req.Filter.CityId, obj.Grade);
            }

            return result;

        }

    }
}
