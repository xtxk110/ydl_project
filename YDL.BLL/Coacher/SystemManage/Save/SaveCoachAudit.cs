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
    /// 修改教练的审核状态
    /// </summary>
    public class SaveCoachAudit : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<Coach>>(request);
            var obj = req.FirstEntity();
            Response result = new Response();
            if (obj.State == AuditState.REFUSE.Id)//审核不通过 操作
            {
                var sql = @"
UPDATE CoachApply SET 
    state=@State, AuditOpinion=@AuditOpinion ,AuditDateTime=GETDATE()
WHERE Id=@Id ";
                var cmd = CommandHelper.CreateText(FetchType.Execute, sql);
                cmd.Params.Add("@State", AuditState.REFUSE.Id);
                cmd.Params.Add("@AuditOpinion", obj.AuditOpinion);
                cmd.Params.Add("@Id", obj.Id);
                result = DbContext.GetInstance().Execute(cmd);
                if (result.IsSuccess)
                {
                    JPushHelper.SendNotify(MasterType.COACH.Id, obj.Id,
                        "你的教练申请已被管理员拒绝",
                       new List<string> { obj.Id });
                }

            }
            else if (obj.State == AuditState.PASS.Id)//审核通过 操作
            {
                //先设置审核表的教练等级
                var sql = @"
UPDATE CoachApply SET
    Grade=@Grade , 
    AuditOpinion=@AuditOpinion ,
    AuditDateTime=GETDATE()
WHERE Id=@Id ";
                var cmd = CommandHelper.CreateText(FetchType.Execute, sql);
                cmd.Params.Add("@Grade", obj.Grade);
                cmd.Params.Add("@AuditOpinion", obj.AuditOpinion);
                cmd.Params.Add("@Id", obj.Id);
                result = DbContext.GetInstance().Execute(cmd);
                if (result.IsSuccess)
                {
                    //再将 审核通过的 记录 更新到 正式表, 并删除审核记录
                    result = SetCoachAuditPass(obj.Id);

                }

                //激光推送
                if (result.IsSuccess)
                {
                    JPushHelper.SendNotify(MasterType.COACH.Id, obj.Id,
                        "恭喜您 ! 你的教练申请, 已审核通过",
                       new List<string> { obj.Id });
                }
            }

            return result;

        }

        public Response SetCoachAuditPass(string Id)
        {
            var cmd = CommandHelper.CreateProcedure(text: "sp_CoachAuditPass");
            cmd.Params.Add(CommandHelper.CreateParam("@Id", Id));
            var result = DbContext.GetInstance().Execute(cmd);
            return result;
        }

        
    }
}
