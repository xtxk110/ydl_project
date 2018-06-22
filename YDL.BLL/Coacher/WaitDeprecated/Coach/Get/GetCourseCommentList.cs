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
    /// 获取课程评论列表
    /// </summary>
    public class GetCourseCommentList : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetCoachRelatedFilter>>(request);
            var sql = @"
SELECT 
	b.HeadUrl,
	b.Sex,
	CommentatorName=CASE WHEN a.IsShareName=1 THEN b.CardName ELSE '匿名用户' END,
	a.Id AS CourseId,
	a.CoacherUserId,
	a.Score,
	a.Comment,
	a.CommentatorId,
	a.IsShareName,
	a.CreateDate
FROM dbo.CoachComment a
INNER JOIN dbo.UserAccount b ON a.CommentatorId=b.Id
WHERE a.CourseId=@CourseId
ORDER BY a.CreateDate DESC

";
            var cmd = CommandHelper.CreateText<CoachComment>(FetchType.Fetch, sql);
            cmd.Params.Add("@CourseId", req.Filter.CourseId);
            var result = DbContext.GetInstance().Execute(cmd);

            return result;

        }


    }
}
