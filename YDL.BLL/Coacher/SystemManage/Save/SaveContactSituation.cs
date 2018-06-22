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
    ///  填写联系情况
    /// </summary>
    public class SaveContactSituation  : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<CoachOrderTrialCourse>>(request);
            var obj = req.FirstEntity();
            var sql = @"
UPDATE CoachOrderTrialCourse 
    SET ContactSituation=@ContactSituation , IsContact=1
WHERE StudentId=@StudentId
";
            var cmd = CommandHelper.CreateText<Coach>(FetchType.Execute, sql);
            cmd.Params.Add("@ContactSituation", obj.ContactSituation);
            cmd.Params.Add("@StudentId", obj.StudentId);

            var result = DbContext.GetInstance().Execute(cmd);
            return result;

        }




    }
}
