
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;

namespace YDL.BLL
{
    /// <summary>
    /// 获取用户运动积分和段位
    /// </summary>
    public class GetMyScoreAndGrade : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<UserSport>>(request);
            var sql = "SELECT a.*,b.GradeName,b.LeftScore,b.RightScore,b.GradeIndex FROM UserSport a LEFT JOIN ScoreGrade b ON a.Score>=b.LeftScore AND a.Score<=b.RightScore WHERE UserId=@userId";
            var cmd = CommandHelper.CreateText<UserSport>(FetchType.Fetch, sql);
            cmd.Params.Add("@userId", currentUser.Id);
            var result = DbContext.GetInstance().Execute(cmd);
            if (result.Entities.Count > 0)
            {
                UserSport us = result.Entities[0] as UserSport;
                ScoreGrade sg = null;
                if (us.GradeIndex == 1)
                {
                    us.PreLeftGradeName = us.GradeName;
                    us.PreLeftScore = us.LeftScore;
                }
                else
                {
                    sg = GetGradeByGradeIndex(us.GradeIndex - 1);//前一段对象
                    us.PreLeftGradeName = sg.GradeName;
                    us.PreLeftScore = sg.RightScore;
                }
                if (us.GradeIndex == 10)//最后一段
                {
                    us.PreLeftGradeName = us.GradeName;
                    us.PreLeftScore = us.RightScore;
                }
                else
                {
                    sg = GetGradeByGradeIndex(us.GradeIndex + 1);//后一段对象
                    us.NextRightGradeName = sg.GradeName;
                    us.NextRightScore = sg.LeftScore;
                }
                

            }

                return result;
        }
        /// <summary>
        /// 根据段位索引获取
        /// </summary>
        /// <param name="gradeIndex"></param>
        /// <returns></returns>
        private ScoreGrade GetGradeByGradeIndex(int gradeIndex)
        {
            ScoreGrade sg = new ScoreGrade();
            if (gradeIndex <= 0)
                gradeIndex = 1;
            else if (gradeIndex > 10)
                gradeIndex = 10;
            var sqlStr = @"SELECT *  FROM ScoreGrade WHERE GradeIndex=@index";
            var cmd = CommandHelper.CreateText<ScoreGrade>(FetchType.Fetch, sqlStr);
            cmd.Params.Add("@index", gradeIndex);
            var result = DbContext.GetInstance().Execute(cmd);
            if (result.Entities.Count > 0)
                sg = result.Entities[0] as ScoreGrade;

            return sg;
        }
    }

}
