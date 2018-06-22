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
    /// 保存教练对学员的训练计划
    /// </summary>
    public class SaveCoachTrainingPlan_186 : IServiceBase
    {

        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<CoachTrainingPlan>>(request);
            var obj = req.FirstEntity();
            var coachTrainPlan = GetTrainingPlan(obj.StudentId, obj.CoachId);
            if (coachTrainPlan == null)//不存在训练计划
            {
                obj.RowState = RowState.Added;
            }
            else
            {
                //存在训练计划,就修改
                obj.Id = coachTrainPlan.Id;
                obj.RowState = RowState.Modified;
            }

            List<EntityBase> entites = new List<EntityBase>();
            entites.Add(obj);
            if (obj.RowState == RowState.Added)
            {
                obj.TrySetNewEntity();
            }

            var result = DbContext.GetInstance().Execute(CommandHelper.CreateSave(entites));
            return result;

        }

        public CoachTrainingPlan GetTrainingPlan(string studentId, string coachId)
        {
            string sql = @"

 SELECT * 
 FROM dbo.CoachTrainingPlan 
 WHERE CoachId=@CoachId AND StudentId=@StudentId
";
            var cmd = CommandHelper.CreateText<CoachTrainingPlan>(FetchType.Fetch, sql);
            cmd.Params.Add("@CoachId", coachId);
            cmd.Params.Add("@StudentId", studentId);

            var result = DbContext.GetInstance().Execute(cmd);
            return result.FirstEntity<CoachTrainingPlan>();
        }

    }
}
