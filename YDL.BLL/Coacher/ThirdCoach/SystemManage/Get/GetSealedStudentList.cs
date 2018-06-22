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
    /// 获取封闭机构或者集训 下的学员列表 
    /// </summary>
    public class GetSealedStudentList_189 : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetCoachRelatedFilter>>(request);
            var cmd = CommandHelper.CreateProcedure<CoachStudent>(text: "sp_GetSealedStudentList");
            cmd.Params.Add(CommandHelper.CreateParam("@StudentName ", req.Filter.StudentName));
            cmd.Params.Add(CommandHelper.CreateParam("@CoachBootcampId ", req.Filter.CoachBootcampId));
            cmd.Params.Add(CommandHelper.CreateParam("@SealedOrganizationId ", req.Filter.SealedOrganizationId));
            cmd.CreateParamPager(req.Filter);

            var result = DbContext.GetInstance().Execute(cmd);
            result.SetRowCount();
            foreach (var item in result.Entities)
            {
                var obj = item as CoachStudent;
                CoachStudentBalance coachStudentBalance = new CoachStudentBalance();
                //获取学员集训课余额
                var balanceObj = CoachHelper.Instance.GetBootcampBalance(obj.UserId, obj.CoachBootcampId);
                if (balanceObj!=null)
                {
                    
                    coachStudentBalance.Amount = balanceObj.Amount;
                    coachStudentBalance.TotalAmount = balanceObj.ThenTotalAmount;
                }
                //获取最后一次上课时间
                coachStudentBalance.LastGoCourseTime= CoachHelper.Instance.GetLastGoCourseTime(obj.UserId, CoachDic.BootcampCourse);
                obj.CoachBootcampBalance = coachStudentBalance;
            }
            return result;


        }


    }
}
