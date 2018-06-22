
using System.Collections.Generic;
using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Utility;
using YDL.Core;
using System;

namespace YDL.BLL
{
    /// <summary>
    /// 获取竞猜排行榜
    /// </summary>
    public class GetGuessRank_188 : IServiceBase
    {

        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetGuessRelatedFilter>>(request);
            var yueDouSumSql = @"

        SELECT 
		    SUM(Amount) AS Amount,
		    UserId
	    FROM dbo.YueDouFlow
	    WHERE FlowType='GuessEarn'
";
            if (!string.IsNullOrEmpty(req.Filter.GameId))
            {
                yueDouSumSql += " AND GameId=@GameId ";
            }
            yueDouSumSql += " GROUP BY UserId ";

            var sql = @"
/*我的排名*/
SELECT 
	ROW_NUMBER() OVER(ORDER BY b.Amount DESC) AS RankNumber,
	a.Sex,
	a.HeadUrl,
	UserName=dbo.fn_GetUserName(a.Id),
	b.Amount
 FROM
 dbo.UserAccount a
 LEFT JOIN 
 (
        " + yueDouSumSql + @"
)b ON a.Id=b.UserId
WHERE a.Id=@UserId
UNION ALL
/*排前十名的*/
SELECT 
	TOP 10
	ROW_NUMBER() OVER(ORDER BY a.Amount DESC) AS RankNumber,
	b.Sex,
	b.HeadUrl,
	UserName=dbo.fn_GetUserName(a.UserId),
	a.Amount
 FROM(
 	     " + yueDouSumSql + @"
)a
INNER JOIN dbo.UserAccount b ON a.UserId=b.Id
 
";
            var cmd = CommandHelper.CreateText<YueDouRank>(FetchType.Fetch, sql);
            cmd.Params.Add("@UserId", req.Filter.CurrentUserId);
            cmd.Params.Add("@GameId", req.Filter.GameId);
            var result = DbContext.GetInstance().Execute(cmd);
            var obj = result.FirstEntity<YueDouRank>();
            //处理第一条用户自己的排名信息
            if (obj != null && obj.Amount == 0)//0表示没有赚得悦豆, 说明他也没有排名, 置为0表示没有排名
            {
                obj.RankNumber = 0;
            }

            return result;
        }



    }

}
