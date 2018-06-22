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
    /// 获取审核教练详细信息
    /// </summary>
    public class GetAuditCoachInfo : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetSystemManageRelatedFilter>>(request);
            string sql = "";
            if (req.Filter.CoachState == AuditState.PASS.Id)
            {
                //从正式数据取教练信息
                sql = @"
SELECT 
	b.HeadUrl,
    b.Sex,
	b.CardName AS Name,
    b.CardId,
    b.Mobile,
	Score=dbo.[fn_GetCoachAVGScore] (a.Id),
	a.*,
	c.Address AS VenueAddress,
	c.Lat AS VenueLat,
	c.Lng AS VenueLng,
    c.Name AS VenueName,
	ResidentAddressAuditState=(
		SELECT CASE WHEN State='010001' THEN 0 ELSE 1 END 
		FROM dbo.Venue 
		WHERE Id=a.VenueId
	)

FROM dbo.Coach a
INNER JOIN dbo.UserAccount b  ON a.Id=b.Id
LEFT JOIN dbo.Venue c ON a.VenueId=c.Id
WHERE a.Id=@CoachId 

";
            }
            else
            {
                //从教练审核表 取教练信息
                sql = @"
                SELECT 
	                a.HeadUrl,
                    b.Sex,
	                a.Name,
                    a.CardId,
                    a.Mobile,
	                Score=dbo.[fn_GetCoachAVGScore] (a.Id),
	                a.*,
	                c.Address AS VenueAddress,
	                c.Lat AS VenueLat,
	                c.Lng AS VenueLng,
                    c.Name AS VenueName,
	                ResidentAddressAuditState=(
		                SELECT CASE WHEN State='010001' THEN 0 ELSE 1 END 
		                FROM dbo.Venue 
		                WHERE Id=a.VenueId
	                )

                FROM dbo.CoachApply a
                INNER JOIN dbo.UserAccount b  ON a.Id=b.Id
                LEFT JOIN dbo.Venue c ON a.VenueId=c.Id
                WHERE a.Id=@CoachId 

                ";
            }


            var cmd = CommandHelper.CreateText<Coach>(FetchType.Fetch, sql);
            cmd.Params.Add("@CoachId", req.Filter.CoachId);


            var result = DbContext.GetInstance().Execute(cmd);
            var obj = result.FirstEntity<Coach>();
            if (obj != null)
            {
                if (obj.BeginTeachingDate != null && obj.BeginTeachingDate != DateTime.MinValue)
                {
                    obj.CoachAge = DateTime.Now.Year - ((DateTime)obj.BeginTeachingDate).Year;
                }

                if (req.Filter.CoachState == AuditState.PASS.Id)
                {

                }

                #region 获取资质文件
                if (req.Filter.CoachState == AuditState.PASS.Id) //审核通过的
                {
                    obj.GetFilesByModule(BusinessType.CoachFormal.Id);
                }
                else if (req.Filter.CoachState == AuditState.PROCESSING.Id
                    || req.Filter.CoachState == AuditState.REFUSE.Id)//审核中和不通过的
                {
                    obj.GetFilesByModule(BusinessType.CoachApply.Id);
                }
                #endregion 获取资质文件

            }
            return result;

        }


    }
}
