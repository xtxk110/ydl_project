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
    /// 保存学员购买的集训课
    /// </summary>
    public class SaveStudentBootcampMoney : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<CoachStudentMoneyNotPay>>(request);
            var obj = req.FirstEntity();
            //验证能否报名
            string errorMsg = "";
            errorMsg = CanJoin(obj);
            if (!string.IsNullOrEmpty(errorMsg))
            {
                return ResultHelper.Fail(errorMsg);
            }
            //开始报名
            List<EntityBase> entites = new List<EntityBase>();
            entites.Add(obj);

            if (obj.RowState == RowState.Added)
            {
               
                obj.ThenTotalAmount = obj.Amount;
                obj.IsPay = false;
                obj.CourseTypeId = "027005";
                obj.CourseTypeName = CoachDic.CoacherCourse["027005"];
                var bootcamp = CoachHelper.Instance.GetCoachBootcampById(obj.CoachBootcampId);
                obj.Deadline = (DateTime)bootcamp.EndTime;
                obj.TrySetNewEntity();
            }

            var result = DbContext.GetInstance().Execute(CommandHelper.CreateSave(entites));
            if (result.IsSuccess)
            {
                //生成 待支付订单
                result = SaveWaitPay(obj, currentUser);
            }
            return result;

        }

        public string CanJoin(CoachStudentMoney obj)
        {
            string sql = @"
SELECT * FROM dbo.CoachBootcamp WHERE Id=@id
";
            var cmd = CommandHelper.CreateText<CoachBootcamp>(FetchType.Fetch, sql);
            cmd.Params.Add("@id", obj.CoachBootcampId);
            var result = DbContext.GetInstance().Execute(cmd);
            var coachBootcamp = result.FirstEntity<CoachBootcamp>();
            if (coachBootcamp == null)
            {
                return "记录已不存在, 不能报名";
            }

            if (coachBootcamp.State == CoachDic.BootcampUnpublish)
            {
                return "课程未发布,不能报名";
            }
            else if (coachBootcamp.State == CoachDic.BootcampFinished)
            {
                return "课程已截止,不能报名";
            }

            if (coachBootcamp.JoinDeadline < DateTime.Now)
            {
                return "课程报名截止时间已过,不能报名";
            }

            return "";

        }

        public Response SaveWaitPay(CoachStudentMoney obj, User currentUser)
        {
            Response rsp = new Response();
            //生成 待支付订单
            var vipUse = new VipUse();
            vipUse.Id = Ext.NewId();
            vipUse.MasterType = MasterType.STUDENTPAYFORBOOTCAMP.Id;
            vipUse.MasterId = obj.Id;
            vipUse.CityId = obj.CityId;
            vipUse.VenueId = "";
            vipUse.CostTypeId = CostType.COACHCOST.Id;

            vipUse.TotalAmount = obj.ThenMoney;
            vipUse.Discount = 1;
            vipUse.Amount = obj.ThenMoney * vipUse.Discount;
            vipUse.PayState = PayState.PAY.Id;//待支付
            vipUse.IsOwnCreate = true;
            vipUse.Remark = "购买了集训课";

            vipUse.UserId = currentUser.Id;
            vipUse.CreatorId = currentUser.Id;
            vipUse.CreateDate = DateTime.Now;
            rsp.Tag = VipHelper.SaveVipUse(vipUse);
            rsp.IsSuccess = true;

            return rsp;
        }


    }
}
