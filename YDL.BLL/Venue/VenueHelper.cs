using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Core;
using YDL.Map;
using YDL.Model;
using YDL.Utility;

namespace YDL.BLL
{
    public class VenueHelper
    {
        public static VenueHelper Instance = new VenueHelper();
        public Venue GetVenueById(string venueId)
        {
            var sql = @"
 SELECT * FROM dbo.Venue WHERE Id=@Id  
";
            var cmd = CommandHelper.CreateText<Venue>(FetchType.Fetch, sql);
            cmd.Params.Add("@Id", venueId);
            var result = DbContext.GetInstance().Execute(cmd);
            return result.FirstEntity<Venue>();
        }
        public static List<Coacher> GetSignInCoacherList(string venueId)
        {
            var sql = @"
SELECT 
	b.HeadUrl,
	b.CardName  AS Name,
	b.Sex,
	a.CoacherUserId AS UserId,
    a.SignOutTime
FROM dbo.VenueSignInOut a
INNER JOIN dbo.UserAccount b ON a.CoacherUserId=b.Id
WHERE VenueId =@VenueId  
";
            var cmd = CommandHelper.CreateText<Coacher>(FetchType.Fetch, sql);
            cmd.Params.Add("@VenueId", venueId);
            var result = DbContext.GetInstance().Execute(cmd);
            return result.Entities.ToList<EntityBase, Coacher>();
        }


    }


}
