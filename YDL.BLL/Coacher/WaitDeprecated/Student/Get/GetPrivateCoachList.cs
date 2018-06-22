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
    /// 学员获取私教列表
    /// </summary>
    public class GetPrivateCoachList : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetCoachRelatedFilter>>(request);
            Response rsp = new Response();
            var isCoach = CoachHelper.Instance.IsCoach(req.Filter.CurrentUserId);
            if (isCoach)
            {
                rsp = GetCurrentUserCoach(req);
            }
            else
            {
                rsp = GetStudentCoachList(req);
            }
            return rsp;
        }

        public Response GetCurrentUserCoach(Request<GetCoachRelatedFilter> req)
        {
            var sql = @"
    SELECT 
		a.Grade,
		a.CreateDate,
		a.Id,
		a.Qualification,
		a.VenueId,
		b.HeadUrl,
        b.Sex,
		b.CardName AS Name,
		Score=dbo.[fn_GetCoachAVGScore] (a.Id),
		VenueAddress=(SELECT Address FROM dbo.Venue WHERE Id=a.VenueId),
		c.Lat AS VenueLat ,
		c.Lng AS VenueLng,
		Distance=dbo.fn_GetDistance(@curUserLat,@curUserLng,c.Lat,c.Lng),
		CoachAge=[dbo].[fn_GetCoachAge](a.BeginTeachingDate)
	FROM  dbo.Coach a
	INNER JOIN dbo.UserAccount b ON a.Id=b.Id
	INNER JOIN dbo.Venue c ON a.VenueId=c.Id
 	WHERE 1=1  AND a.Id=@CoachId AND a.IsEnabled=1
						
";
            var cmd = CommandHelper.CreateText<Coach>(FetchType.Fetch, sql);
            cmd.Params.Add("@curUserLat", req.Filter.CurUserLat);
            cmd.Params.Add("@curUserLng", req.Filter.CurUserLng);
            cmd.Params.Add("@CoachId", req.Filter.CurrentUserId);

            var result = DbContext.GetInstance().Execute(cmd);
            return result;
        }

        public Response GetStudentCoachList(Request<GetCoachRelatedFilter> req)
        {
            var sql = @"
SELECT 
		a.Grade,
		a.CreateDate,
		a.Id,
		a.Qualification,
		a.VenueId,
		b.HeadUrl,
        b.Sex,
		b.CardName AS Name,
		Score=dbo.[fn_GetCoachAVGScore] (a.Id),
		VenueAddress=(SELECT Address FROM dbo.Venue WHERE Id=a.VenueId),
		c.Lat AS VenueLat ,
		c.Lng AS VenueLng,
		Distance=dbo.fn_GetDistance(@curUserLat,@curUserLng,c.Lat,c.Lng),
		CoachAge=[dbo].[fn_GetCoachAge](a.BeginTeachingDate)
	FROM  dbo.Coach a
	INNER JOIN dbo.UserAccount b ON a.Id=b.Id
	INNER JOIN dbo.Venue c ON a.VenueId=c.Id
	INNER JOIN (
		SELECT 
			DISTINCT
			CoachId
		 FROM dbo.CoachStudentMoney
		 WHERE StudentUserId =@StudentUserId AND CoachId IS NOT NULL
 
	) d ON a.id=d.CoachId
 	WHERE 1=1  AND a.IsEnabled=1
						
";
            var cmd = CommandHelper.CreateText<Coach>(FetchType.Fetch, sql);
            cmd.Params.Add("@curUserLat", req.Filter.CurUserLat);
            cmd.Params.Add("@curUserLng", req.Filter.CurUserLng);
            cmd.Params.Add("@StudentUserId", req.Filter.CurrentUserId);

            var result = DbContext.GetInstance().Execute(cmd);
            return result;
        }

    }
}
