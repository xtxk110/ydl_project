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
    /// 保存教练上课打卡
    /// </summary>
    public class SaveCoachStartCard_186 : IServiceBase
    {

        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<CoachCourse>>(request);
            var obj = req.FirstEntity();
            var courseStartTime = (DateTime)obj.BeginTime;

            ////请在上课前10分钟内打卡
            //TimeSpan timeSpan = (courseStartTime).Subtract(DateTime.Now);
            //if ((timeSpan.TotalMinutes + 1) > 10)
            //{
            //    return ResultHelper.Fail("请在上课前10分钟内打卡");
            //}

            var sql = @"
 UPDATE dbo.CoachCourse
 SET 
	State=@State,
	StartCardAddress=@StartCardAddress,
	StartCardTime=@StartCardTime
WHERE Id=@Id
";
            var cmd = CommandHelper.CreateText<ClubUser>(FetchType.Execute, sql);
            cmd.Params.Add("@State", CoachDic.CourseProcessing);
            cmd.Params.Add("@StartCardAddress", obj.StartCardAddress);
            cmd.Params.Add("@StartCardTime", DateTime.Now);
            cmd.Params.Add("@Id", obj.Id);

            var result = DbContext.GetInstance().Execute(cmd);
            result.Tag = DateTime.Now;
            return result;

        }





    }
}
